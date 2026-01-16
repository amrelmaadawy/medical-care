import 'package:dio/dio.dart';
import 'package:medical_care/core/utils/pref_helper.dart';
class DioClient {
  
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: "https://graduation.coderaeg.com",
      connectTimeout: Duration(seconds: 60),
      receiveTimeout: Duration(seconds: 60),
    ),
  );

  DioClient() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler)async {
         final token = await PrefHelper.getToken();
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
      ),
    );
  }

  Dio get dio => _dio;
}