import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_care/features/chat/data/models/doctor_model.dart';
import 'package:medical_care/features/chat/data/repos/chat_repo.dart';

abstract class DoctorsState {}

class DoctorsInitial extends DoctorsState {}
class DoctorsLoading extends DoctorsState {}
class DoctorsSuccess extends DoctorsState {
  final List<DoctorModel> doctors;
  DoctorsSuccess(this.doctors);
}
class DoctorsError extends DoctorsState {
  final String message;
  DoctorsError(this.message);
}

class DoctorsCubit extends Cubit<DoctorsState> {
  final ChatRepo repo;

  DoctorsCubit(this.repo) : super(DoctorsInitial());

  Future<void> fetchDoctors() async {
    emit(DoctorsLoading());
    try {
      final doctors = await repo.getDoctors();
      emit(DoctorsSuccess(doctors));
    } catch (e) {
      emit(DoctorsError(e.toString().replaceFirst('Exception: ', '')));
    }
  }
}
