import 'package:expenseo/features/split/domain/entity/group_entity.dart';

import '../../domain/entity/split_entity.dart';
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

class GroupDetailLoaded extends SplitState {
  final GroupEntity group;
  final List<SplitEntity> expenses;

  GroupDetailLoaded({
    required this.group,
    required this.expenses,
  });

  Map<String, double> calculateBalances(String currentUid) {
    final Map<String, double> balances = {};

    for (final expense in expenses) {
      if (expense.paidBy == currentUid) {
        expense.splitAmong.forEach((uid, share) {
          if (uid != currentUid) {
            balances[uid] = (balances[uid] ?? 0) + share;
          }
        });
      } else {
        final myShare = expense.splitAmong[currentUid] ?? 0;
        if (myShare > 0) {
          balances[expense.paidBy] = (balances[expense.paidBy] ?? 0) - myShare;
        }
      }
    }
    return balances;
  }
}

class UserSearchLoading extends SplitState {}

class UserSearchResult extends SplitState {
 final User user;
  UserSearchResult({
   required this.user
  });
}

class UserSearchNotFound extends SplitState {}
