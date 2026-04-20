import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_care/features/auth/data/auth_model.dart';
import 'package:medical_care/features/auth/data/auth_repo.dart';

// ── States ────────────────────────────────────────────────────────────────────

abstract class SignupState {}

class SignupInitial extends SignupState {}

class SignupLoading extends SignupState {}

class SignupSuccess extends SignupState {
  final AuthModel user;
  SignupSuccess(this.user);
}

class SignupError extends SignupState {
  final String message;
  SignupError(this.message);
}

// ── Cubit ─────────────────────────────────────────────────────────────────────

class SignupCubit extends Cubit<SignupState> {
  final AuthRepo repo;

  SignupCubit(this.repo) : super(SignupInitial());

  Future<void> signup({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
  }) async {
    emit(SignupLoading());
    try {
      final user = await repo.register(
        name: name,
        email: email,
        password: password,
        passwordConfirmation: passwordConfirmation,
      );
      emit(SignupSuccess(user));
    } catch (e) {
      emit(SignupError(e.toString().replaceFirst('Exception: ', '')));
    }
  }
}
