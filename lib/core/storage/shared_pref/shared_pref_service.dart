import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefService {
  static SharedPreferences? _prefs;

  static const _keyUserId = 'user_id';
  static const _keyUserEmail = 'user_email';
  static const _keyUserName = 'user_name';
  static const _keyIsLoggedIn = 'is_logged_in';
  static const _keyIsGuest = 'is_guest';
  static const _keyIsProfileComplete = 'is_profile_complete';
  static const _keyAccessToken = 'access_token';
  static const _keyRefreshToken = 'refresh_token';
  static const _keyLanguageCode = 'language_code';
  static const _keyThemeMode = 'theme_mode';

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<void> saveUser({
    required String id,
    required String email,
    required String name,
    bool isProfileComplete = false,
  }) async {
    await _prefs?.setString(_keyUserId, id);
    await _prefs?.setString(_keyUserEmail, email);
    await _prefs?.setString(_keyUserName, name);
    await _prefs?.setBool(_keyIsLoggedIn, true);
    await _prefs?.setBool(_keyIsGuest, false);
    await _prefs?.setBool(_keyIsProfileComplete, isProfileComplete);
  }

  static Future<void> setGuestMode(bool isGuest) async {
    await _prefs?.setBool(_keyIsGuest, isGuest);
    if (isGuest) {
      await _prefs?.setBool(_keyIsLoggedIn, false);
    }
  }

  static Future<void> setProfileComplete(bool complete) async {
    await _prefs?.setBool(_keyIsProfileComplete, complete);
  }

  static Future<void> setLanguageCode(String languageCode) async {
    await _prefs?.setString(_keyLanguageCode, languageCode);
  }

  static String? getLanguageCode() {
    return _prefs?.getString(_keyLanguageCode);
  }

  static Future<void> setThemeMode(String mode) async {
    await _prefs?.setString(_keyThemeMode, mode);
  }

  static String? getThemeMode() {
    return _prefs?.getString(_keyThemeMode);
  }

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

  static bool isGuest() {
    return _prefs?.getBool(_keyIsGuest) ?? false;
  }

  static bool isProfileComplete() {
    return _prefs?.getBool(_keyIsProfileComplete) ?? false;
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
    await _prefs?.remove(_keyIsGuest);
    await _prefs?.remove(_keyIsProfileComplete);
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
