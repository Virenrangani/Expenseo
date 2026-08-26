import '../../../auth/domain/entity/user.dart';

enum CompleteProfileStatus { initial, loading, success, failure }

class CompleteProfileState {
  final CompleteProfileStatus status;
  final User? user;
  final String? errorMessage;

  const CompleteProfileState({
    this.status = CompleteProfileStatus.initial,
    this.user,
    this.errorMessage,
  });

  CompleteProfileState copyWith({
    CompleteProfileStatus? status,
    User? user,
    String? errorMessage,
  }) {
    return CompleteProfileState(
      status: status ?? this.status,
      user: user ?? this.user,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
