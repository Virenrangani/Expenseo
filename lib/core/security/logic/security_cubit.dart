import 'package:flutter_bloc/flutter_bloc.dart';

import '../service/security_service.dart';
import 'security_state.dart';

class SecurityCubit extends Cubit<SecurityState> {
  final SecurityService _securityService;

  SecurityCubit(this._securityService) : super(SecurityInitial());

  Future<void> init() async {
    final hasPin = await _securityService.hasPin();
    if (hasPin) {
      emit(SecurityLocked());
      final isBioEnabled = await _securityService.isBiometricEnabled();
      if (isBioEnabled) {
        // Auto-trigger on startup only if enabled in settings
        await authenticateWithBiometrics(isAutoTrigger: true);
      }
    } else {
      emit(SecuritySetupRequired());
    }
  }

  void lockApp() {
    if (state is SecurityAuthenticated) {
      emit(SecurityLocked());
    }
  }

  Future<void> authenticateWithPin(String pin) async {
    final isValid = await _securityService.verifyPin(pin);
    if (isValid) {
      emit(SecurityAuthenticated());
    } else {
      emit(SecurityError('Invalid PIN. Please try again.'));
      await Future<void>.delayed(const Duration(seconds: 2));
      emit(SecurityLocked());
    }
  }

  Future<void> disableSecurity() async {
    await _securityService.clearSecurityData();
    emit(SecurityDisabled());
  }

  /// When false (manual tap), we bypass the 'isEnabled' check.
  Future<void> authenticateWithBiometrics({bool isAutoTrigger = false}) async {
    final isAvailable = await _securityService.isBiometricAvailable();
    final isEnabled = await _securityService.isBiometricEnabled();

    // If it's a manual tap (isAutoTrigger = false), we show prompt if hardware is available
    if (isAvailable && (!isAutoTrigger || isEnabled)) {
      final authenticated = await _securityService.authenticateWithBiometrics(
        localizedReason: 'Authenticate to access Expenseo',
      );
      if (authenticated) {
        emit(SecurityAuthenticated());
      }
    }
  }

  Future<void> setupPin(String pin) async {
    await _securityService.setPin(pin);
    emit(SecurityAuthenticated());
  }

  Future<void> toggleBiometric(bool enabled) async {
    await _securityService.setBiometricPreference(enabled);
  }

  void markAuthenticated() {
    emit(SecurityAuthenticated());
  }
}
