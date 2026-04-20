import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  NotificationService._();
  static final NotificationService instance = NotificationService._();

  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  // ── Initialization ──────────────────────────────────────────────────────────

  /// Must be called in main() after WidgetsFlutterBinding.ensureInitialized().
  Future<void> init() async {
    // 1. Load all timezone data
    tz.initializeTimeZones();

    // 2. Get the real device timezone (e.g. "Africa/Cairo", "Asia/Riyadh")
    //    Without this, tz.local defaults to UTC on physical devices
    final String deviceTimezone = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(deviceTimezone));

    if (kDebugMode) {
      print('NotificationService: device timezone = $deviceTimezone');
    }

    // 3. Initialize the plugin with the notification valid icon
    const androidSettings = AndroidInitializationSettings('ic_notification');
    const initSettings = InitializationSettings(android: androidSettings);
    await _plugin.initialize(initSettings);

    final androidPlugin = _plugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();

    // 4. Request POST_NOTIFICATIONS permission (Android 13+ / API 33+)
    //    Without this the notification is silently dropped on Android 13+
    await androidPlugin?.requestNotificationsPermission();

    // 5. Check SCHEDULE_EXACT_ALARM permission (Android 12 / API 31-32)
    //    This is a "special" permission that the user must grant from Settings.
    //    On Android 13+ (API 33+) we declared USE_EXACT_ALARM which is auto-granted.
    final canSchedule = await androidPlugin?.canScheduleExactNotifications();
    if (canSchedule == false) {
      if (kDebugMode) {
        print(
          'NotificationService: SCHEDULE_EXACT_ALARM not granted — '
          'opening system settings for user to enable it.',
        );
      }
      // Opens "Alarms & Reminders" settings page so the user can allow it
      await androidPlugin?.requestExactAlarmsPermission();
    }
  }

  // ── Schedule ────────────────────────────────────────────────────────────────

  /// Schedules a local notification to fire at [scheduledTime] (device local time).
  ///
  /// Uses alarmClock mode — fires reliably on all Android versions even when
  /// the device is in Doze mode, without requiring SCHEDULE_EXACT_ALARM.
  Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledTime,
  }) async {
    if (scheduledTime.isBefore(DateTime.now())) {
      if (kDebugMode) {
        print(
          'NotificationService: skipping past time id=$id ($scheduledTime)',
        );
      }
      return;
    }

    const androidDetails = AndroidNotificationDetails(
      'reminder_channel',
      'Medical Reminders',
      channelDescription: 'Notifications for medical reminders',
      importance: Importance.max,
      priority: Priority.high,
      // Show notification on lock screen
      visibility: NotificationVisibility.public,
    );

    const details = NotificationDetails(android: androidDetails);

    // Convert DateTime to device-local TZDateTime
    final tzScheduled = tz.TZDateTime.from(scheduledTime, tz.local);

    await _plugin.zonedSchedule(
      id,
      title,
      body,
      tzScheduled,
      details,
      // alarmClock = uses AlarmManager.setAlarmClock()
      // → exact, works in Doze mode, no special permission needed beyond manifest
      androidScheduleMode: AndroidScheduleMode.alarmClock,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );

    if (kDebugMode) {
      print(
        'NotificationService: scheduled id=$id at $scheduledTime (tz=$tzScheduled)',
      );
    }
  }

  // ── Cancel ──────────────────────────────────────────────────────────────────

  Future<void> cancelNotification(int id) async {
    await _plugin.cancel(id);
    if (kDebugMode) print('NotificationService: cancelled id=$id');
  }

  Future<void> cancelAll() async {
    await _plugin.cancelAll();
    if (kDebugMode) print('NotificationService: all notifications cancelled');
  }

  // ── Time parsing ────────────────────────────────────────────────────────────

  /// Converts a RecurrenceRule time string to a [DateTime].
  ///
  /// [timeStr] — `"HH:mm:ss"` e.g. `"08:30:00"`
  /// [dateStr] — `"YYYY-MM-DD"` e.g. `"2025-06-01"`. Uses today if null.
  ///
  /// Returns null on any parse failure — callers must null-check the result.
  static DateTime? parseScheduledTime({
    required String? timeStr,
    required String? dateStr,
  }) {
    if (timeStr == null) return null;
    try {
      final parts = timeStr.split(':');
      final hour = int.parse(parts[0]);
      final minute = int.parse(parts[1]);

      final DateTime base = dateStr != null
          ? DateTime.parse(dateStr)
          : DateTime.now();

      return DateTime(base.year, base.month, base.day, hour, minute);
    } catch (e) {
      if (kDebugMode) {
        print('NotificationService.parseScheduledTime error: $e');
      }
      return null;
    }
  }
}
