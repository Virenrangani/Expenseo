import '../../../auth/domain/entity/user.dart';

abstract class ProfileViewState {}

final class ProfileViewInitial extends ProfileViewState {}

final class ProfileViewLoading extends ProfileViewState {}

final class ProfileViewLoaded extends ProfileViewState {
  final User user;
  ProfileViewLoaded(this.user);
}

final class ProfileViewError extends ProfileViewState {
  final String message;
  ProfileViewError(this.message);
}
