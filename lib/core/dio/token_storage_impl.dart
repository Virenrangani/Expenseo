import 'package:shared_preferences/shared_preferences.dart';

import 'token_storage.dart';

class TokenStorageImpl implements TokenStorage {
  static const String accessTokenKey = 'access_token';

  @override
  Future<String?> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(accessTokenKey);
  }

  @override
  Future<void> saveAccessToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(accessTokenKey, token);
  }

  @override
  Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(accessTokenKey);
  }
}