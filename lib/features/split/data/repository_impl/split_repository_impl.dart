import 'package:expenseo/features/split/data/data_source/split_data_source.dart';
import 'package:expenseo/features/split/data/model/group_model.dart';
import 'package:expenseo/features/split/data/model/split_model.dart';
import 'package:expenseo/features/split/domain/entity/group_entity.dart';
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
}