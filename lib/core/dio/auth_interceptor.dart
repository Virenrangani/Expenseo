import 'package:dio/dio.dart';
import 'package:expenseo/core/dio/refresh_token_service.dart';
import 'package:expenseo/core/dio/token_storage.dart';
import 'package:expenseo/features/auth/presentation/page/log_in_page.dart';
import 'package:flutter/material.dart';

import '../../main.dart';

class AuthInterceptor extends Interceptor {
  final Dio dio;
  final TokenStorage tokenStorage;
  final RefreshTokenService refreshService;

  bool _isRefreshing = false;
  Future<String?>? _refreshFuture;

  AuthInterceptor({
    required this.dio,
    required this.tokenStorage,
    required this.refreshService,
  });

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (options.path.contains('/login') ||
        options.path.contains('/register') ||
        options.path.contains('/auth/refresh')) {
      return handler.next(options);
    }

    final token = await tokenStorage.getAccessToken();
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    return handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.response?.statusCode != 401) {
      return handler.next(err);
    }

    final request = err.requestOptions;

    if (request.path.contains('/auth/refresh')) {
      await _handleSessionExpired();
      return handler.next(err);
    }

    try {
      // Synchronize refresh calls across concurrent failed requests
      if (!_isRefreshing) {
        _isRefreshing = true;
        _refreshFuture = refreshService.refresh();
      }

      final newToken = await _refreshFuture;
      _isRefreshing = false;

      // If backend returned null/empty token (refresh token was expired)
      if (newToken == null || newToken.isEmpty) {
        await _handleSessionExpired();
        return handler.next(err);
      }

      // Retry the original request with the fresh token
      request.headers['Authorization'] = 'Bearer $newToken';
      final response = await dio.fetch<dynamic>(request);
      return handler.resolve(response);
    } catch (_) {
      _isRefreshing = false;
      await _handleSessionExpired();
      return handler.next(err);
    }
  }

  Future<void> _handleSessionExpired() async {
    await tokenStorage.clear();

    final context = appNavigatorKey.currentContext;
    if (context != null && context.mounted) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(
            content: Text('Session expired. Please log in again.'),
            backgroundColor: Colors.red,
          ),
        );
    }

    await appNavigatorKey.currentState?.pushAndRemoveUntil(
      MaterialPageRoute<void>(builder: (_) => const LogInPage()),
      (route) => false,
    );
  }
}
