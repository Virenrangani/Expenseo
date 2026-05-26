import 'package:expenseo/features/saving/domain/entity/saving_goal.dart';

abstract class SavingRepository {
  Future<void> createGoal(SavingGoal savingGoal);
  Future<List<SavingGoal>> getAllGoal();
  Future<void> addSavingAmount(String goalId , double savedAmount);
}