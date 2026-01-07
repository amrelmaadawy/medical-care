import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
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
      await getAllReminders();
      emit(PostReminderSuccess());
    } catch (e) {
      emit(PostReminderError(e.toString()));
      if (kDebugMode) {
        print('$e==========================================================');
      }
    }
  }

  Future<void> deletReminder({required int id}) async {
    emit(DeletReminderLoading());
    try {
      await ReminderApi().deleteReminderData(id: id);
      await getAllReminders();
      emit(GetReminderSuccess(reminders));
    } catch (e) {
      if (kDebugMode) {
        print('$e==========================================================');
      }
      emit(DeletReminderError(e.toString()));
    }
  }

  Future<void> editActiveReminder({
    required int id,
    required int active,
  }) async {
    emit(EditeActiveReminderLoading());
    try {
      await ReminderApi().editActiveReminderData(id: id, active: active);
      await getAllReminders();
      emit(GetReminderSuccess(reminders));
    } catch (e) {
      if (kDebugMode) {
        print('$e==========================================================');
        emit(EditeActiveReminderError(e.toString()));
      }
    }
  }
}
