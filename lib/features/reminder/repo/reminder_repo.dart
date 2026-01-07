import 'package:medical_care/features/reminder/model/reminder_model/recurrence_rule.dart';

abstract class ReminderRepo {
  Future<void> getReminderData();
  Future<void> getReminderById({required int id});
  Future<void> postReminderData({
    required String title,
    required String description,
    bool active = true,
    required RecurrenceRule recurrenceRules,
  });
  Future<void> updateReminderData({
    required int id,
    required String title,
    required String description,
    bool active = true,
    required RecurrenceRule recurrenceRules,
  });
    Future<void> editActiveReminderData({required int id,required int active});

  Future<void> deleteReminderData({required int id});
}
