import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_care/features/chat/data/models/conversation_model.dart';
import 'package:medical_care/features/chat/data/repos/chat_repo.dart';

abstract class ConversationsState {}

class ConversationsInitial extends ConversationsState {}
class ConversationsLoading extends ConversationsState {}
class ConversationsSuccess extends ConversationsState {
  final List<ConversationModel> conversations;
  ConversationsSuccess(this.conversations);
}
class ConversationsError extends ConversationsState {
  final String message;
  ConversationsError(this.message);
}

class ConversationsCubit extends Cubit<ConversationsState> {
  final ChatRepo repo;
  Timer? _pollingTimer;

  ConversationsCubit(this.repo) : super(ConversationsInitial());

  Future<void> fetchConversations() async {
    if (state is! ConversationsSuccess) {
      emit(ConversationsLoading());
    }
    await _fetchData();
    _startPolling();
  }

  Future<void> _fetchData() async {
    try {
      final conversations = await repo.getConversations();
      emit(ConversationsSuccess(conversations));
    } catch (e) {
      if (state is! ConversationsSuccess) {
        emit(ConversationsError(e.toString().replaceFirst('Exception: ', '')));
      }
    }
  }

  void _startPolling() {
    _pollingTimer?.cancel();
    _pollingTimer = Timer.periodic(const Duration(seconds: 5), (_) {
      _fetchData();
    });
  }

  @override
  Future<void> close() {
    _pollingTimer?.cancel();
    return super.close();
  }
}
