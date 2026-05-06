import 'package:dio/dio.dart';
import 'package:medical_care/core/network/dio_client.dart';
import 'package:medical_care/features/chat/data/models/doctor_model.dart';
import 'package:medical_care/features/chat/data/models/conversation_model.dart';
import 'package:flutter/foundation.dart';

class ChatRepo {
  final Dio _dio = DioClient().dio;

  Future<List<DoctorModel>> getDoctors() async {
    try {
      final response = await _dio.get('/api/chat/doctors');
      
      final data = response.data;
      if (data == null) throw Exception('الاستجابة فارغة من السيرفر');

      final doctorsData = data['data']?['doctors'] as List?;
      if (doctorsData == null) return [];

      return doctorsData.map((e) => DoctorModel.fromJson(e as Map<String, dynamic>)).toList();
    } on DioException catch (e) {
      if (kDebugMode) {
        print('ChatRepo.getDoctors error: ${e.response?.data}');
      }
      throw Exception('حدث خطأ أثناء تحميل قائمة الأطباء');
    }
  }

  Future<List<ConversationModel>> getConversations() async {
    try {
      final response = await _dio.get('/api/chat/conversations');
      
      final data = response.data;
      if (data == null) throw Exception('الاستجابة فارغة من السيرفر');

      final convData = data['data']?['conversations'] as List?;
      if (convData == null) return [];

      return convData.map((e) => ConversationModel.fromJson(e as Map<String, dynamic>)).toList();
    } on DioException catch (e) {
      if (kDebugMode) {
        print('ChatRepo.getConversations error: ${e.response?.data}');
      }
      throw Exception('حدث خطأ أثناء تحميل المحادثات');
    }
  }

  Future<List<MessageModel>> getChatMessages(int userId) async {
    try {
      final response = await _dio.get('/api/chat/$userId');
      
      final data = response.data;
      if (data == null) throw Exception('الاستجابة فارغة من السيرفر');

      final msgData = data['data'] as List?;
      if (msgData == null) return [];

      return msgData.map((e) => MessageModel.fromJson(e as Map<String, dynamic>)).toList();
    } on DioException catch (e) {
      if (kDebugMode) {
        print('ChatRepo.getChatMessages error: ${e.response?.data}');
      }
      throw Exception('حدث خطأ أثناء تحميل الرسائل');
    }
  }

  Future<MessageModel> sendMessage(int receiverId, String text, {bool askAi = false}) async {
    try {
      final response = await _dio.post(
        '/api/chat/send',
        data: {
          'receiver_id': receiverId,
          'message': text,
          'ask_ai': askAi,
        },
      );
      
      final data = response.data;
      if (data == null) throw Exception('الاستجابة فارغة من السيرفر');

      final msgData = data['data'];
      if (msgData == null) throw Exception('لم يتم إرجاع بيانات الرسالة');

      return MessageModel.fromJson(msgData as Map<String, dynamic>);
    } on DioException catch (e) {
      if (kDebugMode) {
        print('ChatRepo.sendMessage error: ${e.response?.data}');
      }
      throw Exception('حدث خطأ أثناء إرسال الرسالة');
    }
  }

  Future<void> markMessageAsRead(int messageId, int receiverId, String text) async {
    try {
      await _dio.patch(
        '/api/chat/$messageId/read',
        data: {
          'receiver_id': receiverId,
          'message': text,
        },
      );
    } catch (e) {
      if (kDebugMode) {
        print('ChatRepo.markMessageAsRead error: ${e.toString()}');
      }
    }
  }

  Future<void> sendTypingIndicator(int receiverId) async {
    try {
      await _dio.post(
        '/api/chat/typing',
        data: {
          'receiver_id': receiverId,
        },
      );
    } catch (e) {
      if (kDebugMode) {
        print('ChatRepo.sendTypingIndicator error: ${e.toString()}');
      }
    }
  }
}
