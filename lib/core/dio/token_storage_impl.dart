import 'package:expenseo/core/dio/token_storage.dart';

import '../storage/shared_pref/shared_pref_service.dart';

class TokenStorageImpl implements TokenStorage {
  @override
  Future<String?> getAccessToken() async {
    return SharedPrefService.getAccessToken();
  }

  @override
  Future<String?> getRefreshToken() async {
    return SharedPrefService.getRefreshToken();
  }

  @override
  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    await SharedPrefService.saveTokens(
      accessToken: accessToken,
      refreshToken: refreshToken,
    );
  }

  @override
  Future<void> clear() async {
    await SharedPrefService.clearUser();
  }
}
