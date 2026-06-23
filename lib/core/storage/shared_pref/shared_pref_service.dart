import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefService {
  static SharedPreferences? _prefs;

  static const _keyUserId = 'user_id';
  static const _keyUserEmail = 'user_email';
  static const _keyUserName = 'user_name';
  static const _keyIsLoggedIn = 'is_logged_in';
  static const _keyAccessToken = 'access_token';
  static const _keyRefreshToken = 'refresh_token';

  // 🚨 1. CALL THIS ONCE IN MAIN.DART
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<void> saveUser({
    required String id,
    required String email,
    required String name,
  }) async {
    await _prefs?.setString(_keyUserId, id);
    await _prefs?.setString(_keyUserEmail, email);
    await _prefs?.setString(_keyUserName, name);
    await _prefs?.setBool(_keyIsLoggedIn, true);
  }

  // ✅ 2. THESE ARE NOW SYNCHRONOUS! (No more Future)
  static String? getUserId() {
    return _prefs?.getString(_keyUserId);
  }

  static String? getUserEmail() {
    return _prefs?.getString(_keyUserEmail);
  }

  static String? getUserName() {
    return _prefs?.getString(_keyUserName);
  }

  static bool isLoggedIn() {
    return _prefs?.getBool(_keyIsLoggedIn) ?? false;
  }

  static Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    await _prefs?.setString(_keyAccessToken, accessToken);
    await _prefs?.setString(_keyRefreshToken, refreshToken);
  }

  static String? getAccessToken() {
    return _prefs?.getString(_keyAccessToken);
  }

  static Future<void> removeAccessToken() async {
    await _prefs?.remove(_keyAccessToken);
  }

  static Future<void> clearAuth() async {
    await _prefs?.remove(_keyAccessToken);
    await _prefs?.remove(_keyRefreshToken);
  }

  static Future<void> clearUser() async {
    await _prefs?.remove(_keyUserId);
    await _prefs?.remove(_keyUserEmail);
    await _prefs?.remove(_keyUserName);
    await _prefs?.remove(_keyIsLoggedIn);
    await clearAuth();
  }

  static Future<void> saveRefreshToken(String token) async {
    await _prefs?.setString(_keyRefreshToken, token);
  }

  static String? getRefreshToken() {
    return _prefs?.getString(_keyRefreshToken);
  }

  static Future<void> removeRefreshToken() async {
    await _prefs?.remove(_keyRefreshToken);
  }
}
