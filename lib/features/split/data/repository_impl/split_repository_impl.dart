import 'package:expenseo/features/split/data/data_source/split_remote_data_source.dart';
import 'package:expenseo/features/split/data/model/create_group_request_model.dart';
import 'package:expenseo/features/split/data/model/settle_balance_model.dart';
import 'package:expenseo/features/split/data/model/split_model.dart';
import 'package:expenseo/features/split/domain/entity/group_entity.dart';
import 'package:expenseo/features/split/domain/entity/settle_balance.dart';
import 'package:expenseo/features/split/domain/entity/split_entity.dart';
import 'package:expenseo/features/split/domain/repository/split_repository.dart';

import '../../domain/entity/user.dart';

class SplitRepositoryImpl implements SplitRepository {
  final SplitRemoteDataSource remoteDataSource;

  SplitRepositoryImpl(this.remoteDataSource);

  @override
  Future<void> createGroup(CreateGroupRequest group) {
    return remoteDataSource.createGroup(group);
  }

  @override
  Future<User?> searchUserByEmail(String email) async {
    final model = await remoteDataSource.searchUserByEmail(email);

    if (model == null) return null;

    return User(uid: model.id, name: model.name, email: model.email);
  }

  @override
  Future<List<GroupEntity>> getGroups() async {
    final groups = await remoteDataSource.getGroups();

    return groups.map((model) {
      final List<String> memberIds = [];
      final Map<String, String> namesMap = {};

      for (final user in model.members) {
        memberIds.add(user.uid);
        namesMap[user.uid] = user.name;
      }

      return GroupEntity(
        id: model.id,
        name: model.name,
        createdBy: model.id,
        createdAt: model.createdAt,
        members: memberIds,
        memberNames: namesMap,
      );
    }).toList();
  }

  @override
  Future<void> addSplitExpense(SplitEntity expense) {
    return remoteDataSource.addSplitExpense(SplitModel.fromEntity(expense));
  }


  @override
  Future<List<SplitEntity>> getSplitExpenses(String groupId) async {
    final allExpenses = await remoteDataSource.getGroupExpenses(groupId);

    return allExpenses
        .where((e) => e.splitType != SplitType.settlement)
        .map((e) => e.toEntity())
        .toList();
  }


  @override
  Future<void> deleteGroup(String groupId) {
    return remoteDataSource.deleteGroup(groupId);
  }


  @override
  Future<void> settleUp(SettleBalance settlement) {
    return remoteDataSource.settleUp(SettleBalanceModel.fromEntity(settlement));
  }


  @override
  Future<List<SettleBalance>> getSettlements(String groupId) async {
    final allExpenses = await remoteDataSource.getGroupExpenses(groupId);

    final settlementModels = allExpenses.where((e) => e.splitType == SplitType.settlement);

    return settlementModels.map((e) {

      final receiverId = e.splitAmong.keys.first;

      return SettleBalance(
        id: e.id,
        groupId: e.groupId,
        from: e.paidByUserId,
        fromName: e.paidByName,
        to: receiverId,
        toName: 'Receiver',
        amount: e.amount,
        createdAt: e.createdAt,
      );
    }).toList();
  }
}
