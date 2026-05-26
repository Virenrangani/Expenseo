import 'package:expenseo/features/saving/data/data_source/saving_datasource.dart';
import 'package:expenseo/features/saving/data/model/saving_model.dart';
import 'package:expenseo/features/saving/domain/entity/saving_goal.dart';
import 'package:expenseo/features/saving/domain/repository/saving_repository.dart';

class SavingRepositoryImpl extends SavingRepository{
  final SavingDatasource savingDatasource;
  
  SavingRepositoryImpl(this.savingDatasource);


  @override
  Future<void> createGoal(SavingGoal savingGoal) async {
    await savingDatasource.createGoal(SavingModel.fromEntity(savingGoal));
  }

  @override
  Future<List<SavingGoal>> getAllGoal() async{
    final models = await savingDatasource.getAllGoal();
    return models.map((m) => m.toEntity()).toList();
  }
}