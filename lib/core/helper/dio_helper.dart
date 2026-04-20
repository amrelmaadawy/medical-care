import 'package:dio/dio.dart';

import 'package:medical_care/core/network/dio_client.dart';

class DioHelper {
  final Dio _dio = DioClient().dio;

  Future<Response> getData(String path) async {
    return _dio.get(path);
  }

  Future<Response> postData(String path, Map<String, dynamic> data) async {
    return _dio.post(path, data: data);
  }

  Future<Response> patchData(String path, Map<String, dynamic> data) async {
    return _dio.patch(path, data: data);
  }

  Future<Response> putData(String path, Map<String, dynamic> data) async {
    return _dio.put(path, data: data);
  }

  Future<Response> deletData(String path) async {
    return _dio.delete(path);
  }
}
