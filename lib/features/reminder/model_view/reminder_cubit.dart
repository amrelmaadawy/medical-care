import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:medical_care/core/services/notification_service.dart';
import 'package:medical_care/features/reminder/model/reminder_model/recurrence_rule.dart';
import 'package:medical_care/features/reminder/model/reminder_model/reminder_model.dart';
import 'package:medical_care/features/reminder/repo/reminder_api.dart';

part 'reminder_state.dart';

class ReminderCubit extends Cubit<ReminderState> {
  ReminderCubit() : super(ReminderInitial());
  List<ReminderModel> reminders = [];
  Future<void> getAllReminders() async {
    emit(GetReminderLoading());
    try {
      reminders = await ReminderApi().getReminderData();

      emit(GetReminderSuccess(reminders));

      // Reschedule notifications for all active reminders (restored after app restart)
      for (final reminder in reminders) {
        if ((reminder.active ?? 0) == 1 &&
            reminder.id != null &&
            reminder.recurrenceRules != null &&
            reminder.recurrenceRules!.isNotEmpty) {
          final rule = reminder.recurrenceRules!.first;
          final scheduledTime = NotificationService.parseScheduledTime(
            timeStr: rule.time,
            dateStr: rule.startDate,
          );
          if (scheduledTime != null) {
            await NotificationService.instance.scheduleNotification(
              id: reminder.id!,
              title: reminder.title ?? 'تذكير',
              body: reminder.description ?? '',
              scheduledTime: scheduledTime,
            );
          }
        }
      }
    } catch (e) {
      emit(GetReminderError(e.toString()));
    }
  }

  Future<void> getReminderById({required int id}) async {
    emit(GetReminderByIdLoading());
    try {
      await ReminderApi().getReminderById(id: id);

      emit(GetReminderByIdSuccess());
    } catch (e) {
      emit(GetReminderByIdError(e.toString()));
    }
  }Future<void> postReminder({
  required String title,
  required String description,
  required RecurrenceRule recurrenceRules,
}) async {
  try {
    // 1. تنفيذ الـ Post
    await ReminderApi().postReminderData(
      title: title,
      description: description,
      recurrenceRules: recurrenceRules,
    );

    // 2. جلب البيانات فور النجاح
    reminders = await ReminderApi().getReminderData();
    emit(GetReminderSuccess(List.from(reminders)));

    // 3. Schedule a local notification for the newly created reminder
    final newReminder = reminders.lastOrNull;
    if (newReminder?.id != null) {
      final scheduledTime = NotificationService.parseScheduledTime(
        timeStr: recurrenceRules.time,
        dateStr: recurrenceRules.startDate,
      );
      if (scheduledTime != null) {
        await NotificationService.instance.scheduleNotification(
          id: newReminder!.id!,
          title: title,
          body: description,
          scheduledTime: scheduledTime,
        );
      }
    }
    
  } on DioException catch (e) {
    // هنا السر: طباعة الرد القادم من السيرفر (Response Body)
    // غالباً ستجد رسالة مثل: "The frequency field is required"
    String errorMessage = e.response?.data['message'] ?? "حدث خطأ غير متوقع";
    if (e.response?.data['errors'] != null) {
       errorMessage = e.response?.data['errors'].toString() ?? errorMessage;
    }
    emit(GetReminderError(errorMessage));
    print("SERVER ERROR: $errorMessage"); 
  } catch (e) {
    emit(GetReminderError(e.toString()));
  }
}
  Future<void> deletReminder({required int id}) async {
    try {
      // التحديث المحلي السريع (اختياري: ممكن تمسحه بعد نجاح الـ API أو قبله)
      await ReminderApi().deleteReminderData(id: id);
      // Cancel the local notification for this reminder
      await NotificationService.instance.cancelNotification(id);
      reminders.removeWhere((element) => element.id == id);
      
      emit(GetReminderSuccess(List.from(reminders)));
    } catch (e) {
      emit(DeletReminderError(e.toString()));
    }
  }
  Future<void> editActiveReminder({
    required int id,
    required int active,
  }) async {
    emit(EditeActiveReminderLoading());
    try {
      // 1. Update active status on the server
      await ReminderApi().editActiveReminderData(id: id, active: active);

      // 2. Sync the local notification immediately based on the new active value
      if (active == 0) {
        // Switch turned OFF → cancel the notification right away
        await NotificationService.instance.cancelNotification(id);
        if (kDebugMode) {
          print('editActiveReminder: cancelled notification for id=$id');
        }
      } else {
        // Switch turned ON → find the reminder in memory and schedule it
        final reminder = reminders.firstWhere(
          (r) => r.id == id,
          orElse: () => ReminderModel(),
        );
        if (reminder.id != null &&
            reminder.recurrenceRules != null &&
            reminder.recurrenceRules!.isNotEmpty) {
          final rule = reminder.recurrenceRules!.first;
          final scheduledTime = NotificationService.parseScheduledTime(
            timeStr: rule.time,
            dateStr: rule.startDate,
          );
          if (scheduledTime != null) {
            await NotificationService.instance.scheduleNotification(
              id: id,
              title: reminder.title ?? 'تذكير',
              body: reminder.description ?? '',
              scheduledTime: scheduledTime,
            );
            if (kDebugMode) {
              print('editActiveReminder: scheduled notification for id=$id at $scheduledTime');
            }
          }
        }
      }

      // 3. Update local list and emit success (no API re-fetch needed)
      final index = reminders.indexWhere((r) => r.id == id);
      if (index != -1) {
        reminders[index] = reminders[index].copyWith(active: active);
      }
      emit(GetReminderSuccess(List.from(reminders)));
    } catch (e) {
      if (kDebugMode) {
        print('editActiveReminder error: $e');
      }
      emit(EditeActiveReminderError(e.toString()));
    }
  }
}
