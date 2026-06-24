import 'package:expenseo/features/saving/domain/entity/deposit.dart';

import '../../domain/entity/saving_goal.dart';

abstract class SavingState {}

final class SavingInitial extends SavingState {}

final class SavingLoading extends SavingState {}

final class SavingError extends SavingState {
  final String message;

  SavingError(this.message);
}

final class SavingSuccess extends SavingState {
  final String message;

  SavingSuccess(this.message);
}

final class SavingLoaded extends SavingState {
  final List<SavingGoal> goals;
  final List<Deposit>? deposits;

  SavingLoaded(this.goals, this.deposits);

  List<SavingGoal> get activeGoals =>
      goals.where((g) => !g.isCompleted).toList();

  List<SavingGoal> get completedGoals =>
      goals.where((g) => g.isCompleted).toList();
}
