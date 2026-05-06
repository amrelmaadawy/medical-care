import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_care/features/profile/data/contact_repo.dart';

// ── States ────────────────────────────────────────────────────────────────────

abstract class ContactState {}

class ContactInitial extends ContactState {}

class ContactLoading extends ContactState {}

class ContactSuccess extends ContactState {}

class ContactError extends ContactState {
  final String message;
  ContactError(this.message);
}

// ── Cubit ─────────────────────────────────────────────────────────────────────

class ContactCubit extends Cubit<ContactState> {
  final ContactRepo repo;

  ContactCubit(this.repo) : super(ContactInitial());

  Future<void> sendMessage({
    required String name,
    required String email,
    required String message,
  }) async {
    emit(ContactLoading());
    try {
      await repo.sendMessage(name: name, email: email, message: message);
      emit(ContactSuccess());
    } catch (e) {
      emit(ContactError(e.toString().replaceFirst('Exception: ', '')));
    }
  }
}
