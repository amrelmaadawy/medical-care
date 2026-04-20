part of 'symbot_cubit.dart';

@immutable
abstract class SymbotState {}

class SymbotInitial extends SymbotState {}



class GetSymptomsLoading extends SymbotState {}

class GetSymptomsSuccess extends SymbotState {
  final List<Symptom> symbol;
  GetSymptomsSuccess(this.symbol);
}

class GetSymptomsError extends SymbotState {
  final String errorMessage;
  GetSymptomsError(this.errorMessage);
}

class SubmitDiagnosisLoading extends SymbotState {}

class SubmitDiagnosisSuccess extends SymbotState {
  final Map<String, dynamic> result;
  SubmitDiagnosisSuccess(this.result);
}

class SubmitDiagnosisError extends SymbotState {
  final String error;
  SubmitDiagnosisError(this.error);
}

class ChangeSelectedStateSuccess extends SymbotState {}
