import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:medical_care/features/reminder/model/reminder_model/recurrence_rule.dart';
import 'package:medical_care/features/reminder/model/reminder_model/reminder_model.dart';
import 'package:medical_care/features/reminder/repo/reminder_api.dart';
import 'package:meta/meta.dart';

part 'reminder_state.dart';

class ReminderCubit extends Cubit<ReminderState> {
  ReminderCubit() : super(ReminderInitial());
  List<ReminderModel> reminders = [];
  Future<void> getAllReminders() async {
    emit(GetReminderLoading());
    try {
      reminders = await ReminderApi().getReminderData();

      emit(GetReminderSuccess(reminders));
    } catch (e) {
      print(e);
      emit(GetReminderError(e.toString()));
    }
  }

  Future<void> postReminder({
    required String title,
    required String description,
    required RecurrenceRule recurrenceRules,
  }) async {
    emit(PostReminderLoading());
    try {
      await ReminderApi().postReminderData(
        title: title,
        description: description,
        recurrenceRules: recurrenceRules,
      );
      getAllReminders();
      emit(PostReminderSuccess());
    } catch (e) {
      emit(PostReminderError(e.toString()));
      if (kDebugMode) {
        print('$e==========================================================');
      }
    }
  }
}
