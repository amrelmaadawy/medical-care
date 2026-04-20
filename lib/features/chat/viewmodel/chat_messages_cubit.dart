import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_care/features/chat/data/models/conversation_model.dart';
import 'package:medical_care/features/chat/data/repos/chat_repo.dart';

abstract class ChatMessagesState {}

class ChatMessagesInitial extends ChatMessagesState {}
class ChatMessagesLoading extends ChatMessagesState {}
class ChatMessagesSuccess extends ChatMessagesState {
  final List<MessageModel> messages;
  ChatMessagesSuccess(this.messages);
}
class ChatMessagesError extends ChatMessagesState {
  final String message;
  ChatMessagesError(this.message);
}

class ChatMessagesCubit extends Cubit<ChatMessagesState> {
  final ChatRepo repo;
  Timer? _pollingTimer;

  ChatMessagesCubit(this.repo) : super(ChatMessagesInitial());

  Future<void> fetchMessages(int userId) async {
    emit(ChatMessagesLoading());
    try {
      final messages = await repo.getChatMessages(userId);
      emit(ChatMessagesSuccess(messages));
      
      _markUnreadAsRead(messages, userId);
      
      _startPolling(userId);
    } catch (e) {
      emit(ChatMessagesError(e.toString().replaceFirst('Exception: ', '')));
    }
  }

  void _startPolling(int userId) {
    _pollingTimer?.cancel();
    _pollingTimer = Timer.periodic(const Duration(seconds: 3), (_) async {
      try {
        final messages = await repo.getChatMessages(userId);
        if (!isClosed) {
          emit(ChatMessagesSuccess(messages));
          _markUnreadAsRead(messages, userId);
        }
      } catch (e) {
        // Ignore polling errors to not interrupt the UI feed
      }
    });
  }

  void _markUnreadAsRead(List<MessageModel> messages, int userId) {
    for (final msg in messages) {
      if (msg.sender?.id == userId && !msg.isRead) {
        repo.markMessageAsRead(msg.id, userId, msg.message);
      }
    }
  }

  @override
  Future<void> close() {
    _pollingTimer?.cancel();
    return super.close();
  }

  void sendTypingIndicator(int receiverId) {
    repo.sendTypingIndicator(receiverId);
  }

  Future<void> sendMessage(int receiverId, String text, {void Function(String)? onError}) async {
    final currentState = state;
    if (currentState is ChatMessagesSuccess) {
      try {
        final newMessage = await repo.sendMessage(receiverId, text, askAi: false);
        final updatedMessages = List<MessageModel>.from(currentState.messages)..add(newMessage);
        emit(ChatMessagesSuccess(updatedMessages));
      } catch (e) {
        if (onError != null) {
          onError(e.toString().replaceFirst('Exception: ', ''));
        }
      }
    }
  }
}
