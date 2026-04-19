import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:medical_care/core/network/api_service.dart';
import 'package:medical_care/core/utils/pref_helper.dart';
import 'package:medical_care/features/auth/data/auth_model.dart';

class AuthRepo {
  final ApiService _apiService = ApiService();

  Future<AuthModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final data = await _apiService.post(
        '/api/login',
        body: {
          'email': email,
          'password': password,
          'device_name': 'mobile',
        },
      );

      if (data == null) throw Exception('الاستجابة فارغة من السيرفر');

      final model = AuthModel.fromJson(data as Map<String, dynamic>);

      if (model.token.isNotEmpty) {
        await PrefHelper.saveToken(model.token);
      }

      return model;
    } on DioException catch (e) {
      if (kDebugMode) {
        print('AuthRepo.login error: ${e.response?.data}');
      }
      final serverMsg = e.response?.data?['message']?.toString();
      throw Exception(serverMsg ?? 'فشل الاتصال بالسيرفر');
    }
  }
}
