import 'package:expenseo/features/split/data/data_source/split_data_source.dart';
import 'package:expenseo/features/split/data/model/group_model.dart';
import 'package:expenseo/features/split/data/model/settle_balance_model.dart';
import 'package:expenseo/features/split/data/model/split_model.dart';
import 'package:expenseo/features/split/domain/entity/group_entity.dart';
import 'package:expenseo/features/split/domain/entity/settle_balance.dart';
import 'package:expenseo/features/split/domain/entity/split_entity.dart';
import 'package:expenseo/features/split/domain/repository/split_repository.dart';
import '../../domain/entity/user.dart';

class SplitRepositoryImpl implements SplitRepository{
  final SplitDataSource dataSource;

  SplitRepositoryImpl(this.dataSource);

  @override
  Future<void> createGroup(GroupEntity group) {
    return dataSource.createGroup(GroupModel.fromEntity(group));
  }

  @override
  Future<User?> searchUserByEmail(String email) async {
    final model = await dataSource.searchUserByEmail(email);

    if (model == null) return null;

    return User(
      uid: model.uid,
      name: model.name,
      email: model.email,
    );
  }

  @override
  Future<List<GroupEntity>> getGroups()async {
    final groups=await dataSource.getGroups();
    return groups.map((e)=>e.toEntity()).toList();
  }

  @override
  Future<void> addSplitExpense(SplitEntity expense) {
    return dataSource.addSplitExpense(SplitModel.fromEntity(expense));
  }

  @override
  Future<List<SplitEntity>> getSplitExpenses(String groupId) async {
    final splitExpense = await dataSource.getSplitExpenses(groupId);

    return splitExpense.map( 
            (e) => e.toEntity()
    ).toList();
  }

  @override
  Future<void> deleteGroup(String groupId) {
    return dataSource.deleteGroup(groupId);
  }

  @override
  Future<void> settleUp(SettleBalance settlement) {
    return dataSource.settleUp(SettleBalanceModel.fromEntity(settlement));
  }

  @override
  Future<List<SettleBalance>> getSettlements(String groupId)async {
    final models = await dataSource.getSettlements(groupId);
    return models.map((e)=>e.toEntity()).toList();
  }
}