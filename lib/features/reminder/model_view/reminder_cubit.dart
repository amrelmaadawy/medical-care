import 'package:bloc/bloc.dart';
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
}
