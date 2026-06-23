import 'package:expenseo/features/split/data/data_source/split_data_source.dart';
import 'package:expenseo/features/split/data/data_source/split_remote_data_source.dart';
import 'package:expenseo/features/split/data/model/create_group_request_model.dart';
import 'package:expenseo/features/split/data/model/settle_balance_model.dart';
import 'package:expenseo/features/split/data/model/split_model.dart';
import 'package:expenseo/features/split/domain/entity/group_entity.dart';
import 'package:expenseo/features/split/domain/entity/settle_balance.dart';
import 'package:expenseo/features/split/domain/entity/split_entity.dart';
import 'package:expenseo/features/split/domain/repository/split_repository.dart';
import '../../domain/entity/user.dart';

class SplitRepositoryImpl implements SplitRepository{
  final SplitDataSource dataSource;
  final SplitRemoteDataSource remoteDataSource;

  SplitRepositoryImpl(this.dataSource,  this.remoteDataSource);

  @override
  Future<void> createGroup(CreateGroupRequest group) {
    return remoteDataSource.createGroup(group);
  }

  @override
  Future<User?> searchUserByEmail(String email) async {
    final model = await remoteDataSource.searchUserByEmail(email);

    if (model == null) return null;

    return User(
      uid: model.id,
      name: model.name,
      email: model.email,
    );
  }

  @override
  Future<List<GroupEntity>> getGroups()async {
    final groups=await remoteDataSource.getGroups();
    return groups.map(
            (e)=> GroupEntity(id: e.id, name:e.name, createdBy: e.id,  createdAt: e.createdAt, members: [], memberNames: {})
    ).toList();
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
