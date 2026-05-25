import 'package:expenseo/features/saving/domain/entity/saving_goal.dart';
import 'package:expenseo/features/saving/domain/repository/saving_repository.dart';

class SavingUseCase {
  final SavingRepository savingRepository;

  SavingUseCase(this.savingRepository);

  Future<void> createGoal(SavingGoal savingGoal)async {
    await savingRepository.createGoal(savingGoal);
  }

}