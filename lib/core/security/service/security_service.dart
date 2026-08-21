import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';

class SecurityService {
  final LocalAuthentication _auth = LocalAuthentication();
  final FlutterSecureStorage _storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );

  static const String _pinKey = 'user_security_pin';
  static const String _biometricEnabledKey = 'biometric_enabled';

  Future<bool> isBiometricAvailable() async {
    try {
      final bool canCheck = await _auth.canCheckBiometrics;
      final bool isSupported = await _auth.isDeviceSupported();
      return canCheck || isSupported;
    } on PlatformException catch (_) {
      return false;
    }
  }

  Future<bool> authenticateWithBiometrics({
    required String localizedReason,
  }) async {
    try {
      return await _auth.authenticate(
        localizedReason: localizedReason,
        authMessages: const [
          AndroidAuthMessages(
            signInTitle: 'Security Required',
            deviceCredentialsRequiredTitle: 'Please authenticate to continue',
            cancelButton: 'Use PIN',
          ),
        ],
        options: const AuthenticationOptions(stickyAuth: true),
      );
    } on PlatformException catch (_) {
      return false;
    }
  }

  Future<void> setPin(String pin) => _storage.write(key: _pinKey, value: pin);
  Future<String?> getPin() => _storage.read(key: _pinKey);
  Future<bool> hasPin() async => (await getPin()) != null;
  Future<bool> verifyPin(String enteredPin) async =>
      (await getPin()) == enteredPin;

  Future<void> setBiometricPreference(bool enabled) =>
      _storage.write(key: _biometricEnabledKey, value: enabled.toString());

  Future<bool> isBiometricEnabled() async =>
      (await _storage.read(key: _biometricEnabledKey)) == 'true';

  Future<void> clearSecurityData() async {
    await _storage.delete(key: _pinKey);
    await _storage.delete(key: _biometricEnabledKey);
  }
}
