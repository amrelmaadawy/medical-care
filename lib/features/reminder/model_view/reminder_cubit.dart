import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
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
