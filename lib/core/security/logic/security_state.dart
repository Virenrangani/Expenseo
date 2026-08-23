sealed class SecurityState {}

final class SecurityInitial extends SecurityState {}

final class SecuritySetupRequired extends SecurityState {}

final class SecurityLocked extends SecurityState {}

final class SecurityDisabled extends SecurityState {}

final class SecurityAuthenticated extends SecurityState {}

final class SecurityError extends SecurityState {
  final String message;
  SecurityError(this.message);
}
