import 'package:dio/dio.dart';
import 'package:medical_care/core/network/api_error.dart';

class ApiExceptions {
static ApiError handleException(DioException error) {
  switch (error.type){
    case DioExceptionType.connectionTimeout:
    return ApiError(message: 'Connection timeout');
    case DioExceptionType.sendTimeout:
    return ApiError(message: 'Send timeout');
    case DioExceptionType.receiveTimeout:
    return ApiError(message: 'Receive timeout');
    default:
    return ApiError(message: 'Something went wrong');
  }
  
}
}