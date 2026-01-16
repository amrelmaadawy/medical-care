import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:medical_care/features/home/model/symptom.dart';
import 'package:medical_care/features/home/repo/home_api.dart';

part 'symbot_state.dart';

class SymbotCubit extends Cubit<SymbotState> {
  SymbotCubit() : super(SymbotInitial());
 Future<void> getSymptoms() async {
    emit(GetSymptomsLoading());
    try {
      List<Symptom> symbol = await HomeApi().getSymptoms();
      emit(GetSymptomsSuccess(symbol));
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      emit(GetSymptomsError(e.toString()));

    }
  }
  
}
