import 'package:expenseo/features/saving/domain/entity/deposit.dart';
import 'package:expenseo/features/saving/domain/entity/saving_goal.dart';

abstract class SavingRepository {
  Future<void> createGoal(SavingGoal savingGoal);
  Future<List<SavingGoal>> getAllGoal();
  Future<void> addSavingAmount(Deposit deposit);
  Future<List<Deposit>> getAllDeposit(String goalId);
}