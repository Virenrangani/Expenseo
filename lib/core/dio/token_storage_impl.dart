import 'package:expenseo/core/dio/token_storage.dart';

import '../storage/shared_pref/shared_pref_service.dart';

class TokenStorageImpl implements TokenStorage {
  @override
  Future<String?> getAccessToken() {
    return SharedPrefService.getAccessToken();
  }

  @override
  Future<void> saveAccessToken(
      String token,
      ) {
    return SharedPrefService.saveAccessToken(
      token,
    );
  }

  @override
  Future<void> clear() {
    return SharedPrefService.removeAccessToken();
  }
}