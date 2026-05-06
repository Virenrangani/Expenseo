
import '../entity/group_entity.dart';
import '../entity/split_entity.dart';
import '../entity/user.dart';

abstract class SplitRepository {
  Future<void> createGroup(GroupEntity group);

  Future<User?> searchUserByEmail(String email);

  Future<List<GroupEntity>> getGroups();

  Future<void> addSplitExpense(SplitEntity expense);

}