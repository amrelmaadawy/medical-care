import 'package:flutter/foundation.dart';
import 'package:medical_care/core/network/dio_client.dart';
import 'package:dio/dio.dart';

class ContactRepo {
  final Dio _dio = DioClient().dio;

  /// Sends a contact-us message to the server.
  /// Throws an [Exception] with an Arabic message on failure.
  Future<void> sendMessage({
    required String name,
    required String email,
    required String message,
  }) async {
    try {
      await _dio.post(
        '/api/contact-us',
        data: {'name': name, 'email': email, 'message': message},
      );
    } on DioException catch (e) {
      if (kDebugMode) {
        print('ContactRepo.sendMessage error: ${e.response?.data}');
      }
      final serverMsg = e.response?.data?['message']?.toString();
      throw Exception(serverMsg ?? 'فشل إرسال الرسالة. حاول مرة أخرى.');
    }
  }
}
