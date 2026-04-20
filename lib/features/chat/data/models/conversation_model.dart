import 'package:medical_care/core/helper/type_parser.dart';

class ChatParticipant {
  final int id;
  final String name;

  ChatParticipant({required this.id, required this.name});

  factory ChatParticipant.fromJson(Map<String, dynamic> json) {
    return ChatParticipant(
      id: TypeParser.parseInt(json['id']) ?? 0,
      name: TypeParser.parseString(json['name']) ?? 'Unknown',
    );
  }
}

class MessageModel {
  final int id;
  final String message;
  final bool isAi;
  final bool isRead;
  final String? readAt;
  final ChatParticipant? sender;
  final ChatParticipant? receiver;
  final String createdAt;

  MessageModel({
    required this.id,
    required this.message,
    required this.isAi,
    required this.isRead,
    this.readAt,
    this.sender,
    this.receiver,
    required this.createdAt,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: TypeParser.parseInt(json['id']) ?? 0,
      message: TypeParser.parseString(json['message']) ?? '',
      isAi: json['is_ai'] == true || json['is_ai'] == 1,
      isRead: json['is_read'] == true || json['is_read'] == 1,
      readAt: TypeParser.parseString(json['read_at']),
      sender: json['sender'] != null ? ChatParticipant.fromJson(TypeParser.parseMap(json['sender']) ?? {}) : null,
      receiver: json['receiver'] != null ? ChatParticipant.fromJson(TypeParser.parseMap(json['receiver']) ?? {}) : null,
      createdAt: TypeParser.parseString(json['created_at']) ?? '',
    );
  }
}

class ConversationModel {
  final int userId;
  final MessageModel? lastMessage;
  final int unreadCount;

  ConversationModel({
    required this.userId,
    this.lastMessage,
    required this.unreadCount,
  });

  factory ConversationModel.fromJson(Map<String, dynamic> json) {
    return ConversationModel(
      userId: TypeParser.parseInt(json['user_id']) ?? 0,
      lastMessage: json['last_message'] != null 
          ? MessageModel.fromJson(TypeParser.parseMap(json['last_message']) ?? {}) 
          : null,
      unreadCount: TypeParser.parseInt(json['unread_count']) ?? 0,
    );
  }
}
