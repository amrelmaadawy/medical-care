import 'package:medical_care/features/reminder/model/reminder_model/recurrence_rule.dart';

abstract class ReminderRepo {
  Future<void> getReminderData();
  Future<void> postReminderData({
    required String title,
    required String description,
    bool active = true,
    required RecurrenceRule recurrenceRules,
  });
  Future<void> updateReminderData();
  Future<void> deleteReminderData();
}
