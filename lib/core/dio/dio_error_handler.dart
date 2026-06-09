import 'package:dio/dio.dart';

import 'api_exception.dart';

class DioErrorHandler {
  static ApiException handle(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return const ApiException(message: 'Connection timeout');

      case DioExceptionType.receiveTimeout:
        return const ApiException(message: 'Receive timeout');

      case DioExceptionType.sendTimeout:
        return const ApiException(message: 'Send timeout');

      case DioExceptionType.connectionError:
        return const ApiException(message: 'No internet connection');

      case DioExceptionType.badResponse:
        return ApiException(
          statusCode: e.response?.statusCode,
          message: (e.response?.data['message'] ?? 'Something went wrong')
              .toString(),
        );

      default:
        return const ApiException(message: 'Unexpected error occurred');
    }
  }
}
