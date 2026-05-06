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

class GetReminderByIdLoading extends ReminderState {}

class GetReminderByIdSuccess extends ReminderState {}

class GetReminderByIdError extends ReminderState {
  final String error;
  GetReminderByIdError(this.error);
}

class PostReminderLoading extends ReminderState {}

class PostReminderSuccess extends ReminderState {}

class PostReminderError extends ReminderState {
  final String error;
  PostReminderError(this.error);
}

class DeletReminderLoading extends ReminderState {}

class DeletReminderSuccess extends ReminderState {}

class DeletReminderError extends ReminderState {
  final String error;
  DeletReminderError(this.error);
}

class EditeActiveReminderLoading extends ReminderState {}

class EditeActiveReminderSuccess extends ReminderState {}

class EditeActiveReminderError extends ReminderState {
  final String error;
  EditeActiveReminderError(this.error);
}
