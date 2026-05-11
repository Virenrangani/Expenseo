import 'package:expenseo/features/split/domain/entity/group_entity.dart';
import 'package:expenseo/features/split/domain/entity/settle_balance.dart';
import 'package:expenseo/features/split/domain/entity/split_entity.dart';
import 'package:expenseo/features/split/domain/repository/split_repository.dart';

import '../entity/user.dart';

class SplitUseCase {
  final SplitRepository repository;
  SplitUseCase(this.repository);

  Future<void> createGroup(GroupEntity group){
    return repository.createGroup(group);
  }

  Future<User?> searchUserByEmail(String email) {
    return repository.searchUserByEmail(email);
  }

  Future<List<GroupEntity>> getGroups(){
    return repository.getGroups();
  }

  Future<void> addSplitExpense(SplitEntity expense){
    return repository.addSplitExpense(expense);
  }

  Future<List<SplitEntity>> getSplitExpense(String groupId){
    return repository.getSplitExpenses(groupId);
  }

  Future<void> deleteGroup(String groupId){
    return repository.deleteGroup(groupId);
  }

  Future<void> settleUp(SettleBalance settlement){
    return repository.settleUp(settlement);
  }

  Future<List<SettleBalance>> getSettlements(String groupId){
    return repository.getSettlements(groupId);
  }
}