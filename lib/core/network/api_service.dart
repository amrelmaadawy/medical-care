import 'package:dio/dio.dart';
import 'package:medical_care/core/network/api_exceptions.dart';
import 'package:medical_care/core/network/dio_client.dart';

class ApiService {
  final DioClient _dioClient= DioClient();
  // CURD METHODS 
  //1 GET
  Future <dynamic>get(String endpoint)async{
    try {
      final response=await _dioClient.dio.get(endpoint);
      return response.data;
    } on DioException catch (e) { 
      return ApiExceptions.handleException(e);
    }
  }

//2 POST
    Future <dynamic>post(String endpoint, {required Map<String, dynamic> body})async{
    try {
      final response=await _dioClient.dio.post(endpoint, data: body);
      return response.data;
    } on DioException catch (e) {
      return ApiExceptions.handleException(e);
    }
  }

  //3 PUT
  Future <dynamic>put(String endpoint, {required Map<String, dynamic> body})async{
    try {
      final response=await _dioClient.dio.put(endpoint, data: body);
      return response.data;
    } on DioException catch (e) {
      return ApiExceptions.handleException(e);
    }
  }

  //4 DELETE
  Future <dynamic>delete(String endpoint,{required Map<String, dynamic> body})async{
    try {
      final response=await _dioClient.dio.delete(endpoint);
      return response.data;
    } on DioException catch (e) {
      return ApiExceptions.handleException(e);
    }
  }
}