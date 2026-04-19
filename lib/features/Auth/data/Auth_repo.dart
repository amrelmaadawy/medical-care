import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:medical_care/core/network/dio_client.dart';
import 'package:medical_care/core/services/notification_service.dart';
import 'package:medical_care/core/utils/pref_helper.dart';
import 'package:medical_care/features/auth/data/auth_model.dart';

class AuthRepo {
  // Use DioClient directly — ApiService.post() swallows DioException and
  // returns ApiError objects instead of throwing, which crashes the cast
  // `data as Map<String, dynamic>` inside login().
  final Dio _dio = DioClient().dio;

  Future<AuthModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _dio.post(
        '/api/login',
        data: {'email': email, 'password': password, 'device_name': 'mobile'},
      );

      final data = response.data;
      if (data == null) throw Exception('الاستجابة فارغة من السيرفر');

      final model = AuthModel.fromJson(data as Map<String, dynamic>);

      if (model.token.isNotEmpty) {
        await PrefHelper.saveToken(model.token);
        await PrefHelper.saveName(model.name);
        await PrefHelper.saveEmail(model.email);
      }

      return model;
    } on DioException catch (e) {
      if (kDebugMode) {
        print('AuthRepo.login error: ${e.response?.data}');
      }
      final serverMsg = e.response?.data?['message']?.toString();
      throw Exception(
        serverMsg ?? 'البريد الإلكتروني أو كلمة المرور غير صحيحة',
      );
    }
  }

  Future<void> logout() async {
    try {
      // Best-effort API call — if it fails, still clear local data
      await _dio.post('/api/logout', data: {});
    } on DioException catch (e) {
      if (kDebugMode) {
        print('AuthRepo.logout error: ${e.response?.data}');
      }
      // Intentionally not rethrowing — always log out locally
    }

    await PrefHelper.removeToken();
    await NotificationService.instance.cancelAll();
  }
}
