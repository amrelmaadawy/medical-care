import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_care/features/auth/data/auth_model.dart';
import 'package:medical_care/features/auth/data/auth_repo.dart';

// ── States ────────────────────────────────────────────────────────────────────

abstract class SigninState {}

class SigninInitial extends SigninState {}

class SigninLoading extends SigninState {}

class SigninSuccess extends SigninState {
  final AuthModel user;
  SigninSuccess(this.user);
}

class SigninError extends SigninState {
  final String message;
  SigninError(this.message);
}

// ── Cubit ─────────────────────────────────────────────────────────────────────

class SigninCubit extends Cubit<SigninState> {
  final AuthRepo repo;

  SigninCubit(this.repo) : super(SigninInitial());

  Future<void> signin({
    required String email,
    required String password,
  }) async {
    emit(SigninLoading());
    try {
      final user = await repo.login(email: email, password: password);
      emit(SigninSuccess(user));
    } catch (e) {
      emit(SigninError(e.toString().replaceFirst('Exception: ', '')));
    }
  }
}
