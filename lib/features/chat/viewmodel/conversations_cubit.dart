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

  ConversationsCubit(this.repo) : super(ConversationsInitial());

  Future<void> fetchConversations() async {
    emit(ConversationsLoading());
    try {
      final conversations = await repo.getConversations();
      emit(ConversationsSuccess(conversations));
    } catch (e) {
      emit(ConversationsError(e.toString().replaceFirst('Exception: ', '')));
    }
  }
}
