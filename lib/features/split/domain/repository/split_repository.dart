import 'package:expenseo/features/split/data/model/create_group_request_model.dart';
import 'package:expenseo/features/split/domain/entity/settle_balance.dart';

import '../entity/group_entity.dart';
import '../entity/split_entity.dart';
import '../entity/user.dart';

abstract class SplitRepository {
  Future<void> createGroup(CreateGroupRequest group);

  Future<User?> searchUserByEmail(String email);

  Future<List<GroupEntity>> getGroups();

  Future<void> addSplitExpense(SplitEntity expense);

  Future<List<SplitEntity>> getSplitExpenses(String groupId);

  Future<void> deleteGroup(String groupId);

  Future<void> settleUp(SettleBalance settlement);

  Future<List<SettleBalance>> getSettlements(String groupId);
}