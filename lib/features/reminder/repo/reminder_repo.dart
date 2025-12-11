abstract class ReminderRepo {
  Future<void> getReminderData();
  Future<void> postReminderData();
  Future<void> updateReminderData();
  Future<void> deleteReminderData();
}
