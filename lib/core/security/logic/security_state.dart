sealed class SecurityState {}

final class SecurityInitial extends SecurityState {}

/// User has not set up a security PIN yet
final class SecuritySetupRequired extends SecurityState {}

/// App is locked and requires PIN or Biometric authentication
final class SecurityLocked extends SecurityState {}

/// App security (PIN) has been disabled by the user
final class SecurityDisabled extends SecurityState {}

/// App is authenticated and accessible
final class SecurityAuthenticated extends SecurityState {}

/// Error state for failed authentication or hardware issues
final class SecurityError extends SecurityState {
  final String message;
  SecurityError(this.message);
}
