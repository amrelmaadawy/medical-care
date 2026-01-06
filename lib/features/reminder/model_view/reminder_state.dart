part of 'reminder_cubit.dart';

@immutable
abstract class ReminderState {}

class ReminderInitial extends ReminderState {}

class GetReminderLoading extends ReminderState {}

class GetReminderSuccess extends ReminderState {
  final List<ReminderModel> reminders;
  GetReminderSuccess(this.reminders);
}

class GetReminderError extends ReminderState {
  final String error;
  GetReminderError(this.error);
}

class PostReminderLoading extends ReminderState {}

class PostReminderSuccess extends ReminderState {}

class PostReminderError extends ReminderState {
  final String error;
  PostReminderError(this.error);
}
