import 'package:dio/dio.dart';
import 'package:expenseo/core/dio/refresh_token_service.dart';
import 'package:expenseo/core/dio/token_storage.dart';

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
    if (options.path.contains('/login') || options.path.contains('/auth/refresh')) {
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
      return handler.next(err);
    }

    try {
      if (!_isRefreshing) {
        _isRefreshing = true;
        _refreshFuture = refreshService.refresh();
      }

      // Only await it once
      final newToken = await _refreshFuture;
      _isRefreshing = false;

      if (newToken == null) {
        await tokenStorage.clear();
        return handler.next(err);
      }

      // Update the failed request with the new token
      request.headers['Authorization'] = 'Bearer $newToken';
      final response = await dio.fetch(request);

      return handler.resolve(response);

    } catch (_) {
      _isRefreshing = false;
      await tokenStorage.clear();
      return handler.next(err);
    }
  }
}
