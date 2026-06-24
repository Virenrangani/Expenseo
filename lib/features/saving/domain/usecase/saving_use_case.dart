import 'package:expenseo/features/saving/domain/entity/deposit.dart';
import 'package:expenseo/features/saving/domain/entity/saving_goal.dart';
import 'package:expenseo/features/saving/domain/repository/saving_repository.dart';

class SavingUseCase {
  final SavingRepository savingRepository;

  SavingUseCase(this.savingRepository);

  Future<void> createGoal(SavingGoal savingGoal)async {
    await savingRepository.createGoal(savingGoal);
  }

  Future<List<SavingGoal>> getAllGoal(){
    return savingRepository.getAllGoal();
  }

  Future<void> addSavingAmount(Deposit deposit)async {
    await savingRepository.addSavingAmount(deposit);
  }

  Future<List<Deposit>> getAllDeposit(String goalId) {
    return savingRepository.getAllDeposit(goalId);
  }

}