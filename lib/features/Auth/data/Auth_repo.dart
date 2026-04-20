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

      final responseData = response.data;
      if (responseData == null) throw Exception('الاستجابة فارغة من السيرفر');

      final dataMap = (responseData is Map && responseData['data'] != null)
          ? responseData['data']
          : responseData;

      final model = AuthModel.fromJson(dataMap as Map<String, dynamic>);

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
      String? serverMsg;
      if (e.response?.data is Map) {
        serverMsg = e.response?.data?['message']?.toString();
      }
      throw Exception(
        serverMsg ?? 'البريد الإلكتروني أو كلمة المرور غير صحيحة',
      );
    }
  }

  Future<AuthModel> register({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
  }) async {
    try {
      final response = await _dio.post(
        '/api/register',
        data: {
          'name': name,
          'email': email,
          'password': password,
          'password_confirmation': passwordConfirmation,
        },
      );

      final responseData = response.data;
      if (responseData == null) throw Exception('الاستجابة فارغة من السيرفر');

      final dataMap = (responseData is Map && responseData['data'] != null)
          ? responseData['data']
          : responseData;
          
      final model = AuthModel.fromJson(dataMap as Map<String, dynamic>);

      if (model.token.isNotEmpty) {
        await PrefHelper.saveToken(model.token);
        await PrefHelper.saveName(model.name);
        await PrefHelper.saveEmail(model.email);
      }

      return model;
    } on DioException catch (e) {
      if (kDebugMode) {
        print('AuthRepo.register error: ${e.response?.data}');
      }
      String? serverMsg;
      dynamic errors;
      if (e.response?.data is Map) {
        serverMsg = e.response?.data?['message']?.toString();
        errors = e.response?.data?['errors'];
      }
      
      String errorMsg = serverMsg ?? 'حدث خطأ أثناء إنشاء الحساب';
      if (errors != null && errors is Map && errors.isNotEmpty) {
        final firstError = errors.values.first;
        if (firstError is List && firstError.isNotEmpty) {
          errorMsg = firstError.first.toString();
        } else {
          errorMsg = firstError.toString();
        }
      }
      throw Exception(errorMsg);
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
