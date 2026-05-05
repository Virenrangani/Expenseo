import 'package:expenseo/features/split/domain/entity/group_entity.dart';

import '../../domain/entity/user.dart';

sealed class SplitState {}

final class SplitInitial extends SplitState {}

final class SplitLoading extends SplitState {}

final class SplitSuccess extends SplitState {
  final String message;
  SplitSuccess(this.message);
}

final class SplitLoaded extends SplitState{
  final List<GroupEntity> groups;
  SplitLoaded(this.groups);
}

final class SplitError extends SplitState {
  final String message;
  SplitError(this.message);
}

class UserSearchLoading extends SplitState {}

class UserSearchResult extends SplitState {
 final User user;
  UserSearchResult({
   required this.user
  });
}

class UserSearchNotFound extends SplitState {}
