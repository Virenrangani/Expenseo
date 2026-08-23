import 'package:expenseo/core/validation/amount_validation/amount_validation.dart';
import 'package:expenseo/features/saving/domain/entity/deposit.dart';
import 'package:expenseo/features/saving/domain/usecase/saving_use_case.dart';
import 'package:expenseo/features/saving/presentation/cubit/saving_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/extension/localization_extension.dart';
import '../../domain/entity/saving_goal.dart';

class SavingCubit extends Cubit<SavingState> {
  final SavingUseCase savingGoalUseCase;

  SavingCubit(this.savingGoalUseCase) : super(SavingInitial()) {
    getAllGoal();
  }

  String? validateGoal(String value, BuildContext context) {
    if (value.trim().isEmpty) {
      return context.l10n.goalRequired;
    }
    return null;
  }

  String? validateGoalImage(String value, BuildContext context) {
    if (value.trim().isEmpty) {
      return context.l10n.goalImageRequired;
    }
    return null;
  }

  String? validateTargetAmount(String value, BuildContext context) {
    return validateAmount(value, context);
  }

  Future<void> createGoal({
    required String goalImage,
    required String goal,
    required double targetAmount,
    required BuildContext context,
  }) async {
    emit(SavingLoading());
    try {
      final saveGoal = SavingGoal(
        id: const Uuid().v4(),
        goal: goal,
        goalImage: goalImage,
        targetAmount: targetAmount,
        savedAmount: 0,
        isCompleted: false,
        createdAt: DateTime.now(),
      );

      await savingGoalUseCase.createGoal(saveGoal);
      emit(SavingSuccess(context.l10n.goalCreate));
      await getAllGoal();
    } catch (e) {
      emit(SavingError(e.toString()));
    }
  }

  Future<void> getAllGoal() async {
    emit(SavingLoading());
    try {
      final goals = await savingGoalUseCase.getAllGoal();
      emit(SavingLoaded(goals, []));
    } catch (e) {
      emit(SavingError(e.toString()));
    }
  }

  Future<void> addSavingAmount(String goalId, double savedAmount) async {
    emit(SavingLoading());
    try {
      final deposit = Deposit(
        id: const Uuid().v4(),
        goalId: goalId,
        amount: savedAmount,
        createdAt: DateTime.now(),
      );

      await savingGoalUseCase.addSavingAmount(deposit);
      emit(SavingSuccess('Saved amount added..!!'));
      await getAllGoal();
    } catch (e) {
      emit(SavingError(e.toString()));
    }
  }

  Future<void> getAllDeposit(String goalId) async {
    emit(SavingLoading());
    {
      try {
        final deposits = await savingGoalUseCase.getAllDeposit(goalId);

        emit(SavingLoaded([], deposits));
      } catch (e) {
        emit(SavingError(e.toString()));
      }
    }
  }
}
