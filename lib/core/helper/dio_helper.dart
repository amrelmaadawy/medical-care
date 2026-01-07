import 'package:dio/dio.dart';

class DioHelper {
  final Dio _dio = Dio(
    BaseOptions(
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization":
            "Bearer 20|EbMjqythDvhibL03ZRM6pkxNMnbY6o0OjtLSGuPp2a346475",
      },
    ),
  );

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
