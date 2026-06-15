import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../constant/api_url/base_url.dart';
import 'auth_api.dart';
import 'auth_interceptor.dart';
import 'refresh_token_service.dart';
import 'token_storage.dart';

class DioClient {
  static Dio create({required TokenStorage tokenStorage}) {
    final baseOptions = BaseOptions(
      baseUrl: BaseUrl.baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
      contentType: Headers.jsonContentType,
      headers: {'Accept': 'application/json'},
    );

    final dio = Dio(baseOptions);

    final authDio = Dio(baseOptions);

    final authApi = AuthApi(authDio);

    final refreshService = RefreshTokenService(
      authApi: authApi,
      tokenStorage: tokenStorage,
    );

    dio.interceptors.add(
      AuthInterceptor(
        dio: dio,
        tokenStorage: tokenStorage,
        refreshService: refreshService,
      ),
    );

    if (kDebugMode) {
      dio.interceptors.add(
        LogInterceptor(requestBody: true, responseBody: true),
      );
    }

    return dio;
  }
}
