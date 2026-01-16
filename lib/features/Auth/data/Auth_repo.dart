import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:medical_care/core/network/api_service.dart';
import 'package:medical_care/features/Auth/signup/signup_model.dart';

class AuthRepo {
  ApiService apiService = ApiService();

  // sign in
  Future<UserModel?> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await apiService.post(
        '/auth/login',
        body: {'email': email, 'password': password},
      );
      return UserModel.fromJson(response.data);
    } on DioException catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return null;
  }
}
