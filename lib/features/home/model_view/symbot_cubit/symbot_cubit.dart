import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:medical_care/features/home/model/symptom.dart';
import 'package:medical_care/features/home/repo/home_api.dart';
import 'package:image_picker/image_picker.dart';

part 'symbot_state.dart';

class SymbotCubit extends Cubit<SymbotState> {
  SymbotCubit() : super(SymbotInitial());

  List<bool> selectedStates = [];
  List<Symptom> symbol = [];
  Future<void> getSymptoms() async {
    emit(GetSymptomsLoading());
    try {
      symbol = await HomeApi().getSymptoms();
      selectedStates = List.filled(symbol.length, false);
      emit(GetSymptomsSuccess(symbol));
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      emit(GetSymptomsError(e.toString()));
    }
  }

  void toggleSelection(int index) {
    if (index >= 0 && index < selectedStates.length) {
      selectedStates[index] = !selectedStates[index];
      emit(GetSymptomsSuccess(symbol)); // emit عشان تحدث الـ UI
    }
  }

  List<Symptom> getSelectedSymptoms() {
    List<Symptom> selected = [];
    for (int i = 0; i < symbol.length; i++) {
      if (selectedStates[i]) {
        selected.add(symbol[i]);
      }
    }
    return selected;
  }

  bool hasSelection() {
    return selectedStates.contains(true);
  }

  // عدد العناصر المختارة
  int getSelectedCount() {
    return selectedStates.where((selected) => selected).length;
  }

  List<XFile> selectedImages = [];

  void updateImages(List<XFile> images) {
    selectedImages = images;
  }

  int? patientAge;
  String? patientGender;
  int? durationDays;

  Future<void> submitDiagnosis() async {
    if (selectedImages.isEmpty) {
      emit(SubmitDiagnosisError("الرجاء رفع صورة الطفح الجلدي"));
      return;
    }

    final selectedSymptomsList = getSelectedSymptoms().map((e) => e.name).toList();
    if (selectedSymptomsList.isEmpty) {
      emit(SubmitDiagnosisError("الرجاء اختيار بعض الأعراض"));
      return;
    }

    final symptomsText = selectedSymptomsList.join("، ");

    emit(SubmitDiagnosisLoading());
    try {
      final result = await HomeApi().submitAiDiagnosis(
        imagePath: selectedImages.first.path,
        symptomsText: symptomsText,
        age: patientAge,
        gender: patientGender,
        durationDays: durationDays,
      );
      emit(SubmitDiagnosisSuccess(result));
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      emit(SubmitDiagnosisError("فشل إرسال التشخيص، تأكد من الإنترنت وحاول مرة أخرى"));
    }
  }
}
