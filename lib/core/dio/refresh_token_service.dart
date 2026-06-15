import 'package:expenseo/core/dio/token_storage.dart';

import 'auth_api.dart';

class RefreshTokenService {
  final AuthApi authApi;
  final TokenStorage tokenStorage;

  RefreshTokenService({required this.authApi, required this.tokenStorage});

  Future<String?> refresh() async {
    try {
      final refreshToken = await tokenStorage.getRefreshToken();

      if (refreshToken == null) {
        return null;
      }

      final result = await authApi.refreshToken(refreshToken);
      final accessToken = result.accessToken;
      final newRefreshToken = result.refreshToken;

      await tokenStorage.saveTokens(
        accessToken: accessToken,
        refreshToken: newRefreshToken,
      );

      return accessToken;
    } catch (_) {
      return null;
    }
  }
}
