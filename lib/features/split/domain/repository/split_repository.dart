
import '../entity/group_entity.dart';
import '../entity/user.dart';

abstract class SplitRepository {
  Future<void> createGroup(GroupEntity group);

  Future<User?> searchUserByEmail(String email);

}