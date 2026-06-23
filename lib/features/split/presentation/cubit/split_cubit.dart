import 'package:expenseo/core/constant/string/app_string.dart';
import 'package:expenseo/features/split/data/model/create_group_request_model.dart';
import 'package:expenseo/features/split/domain/entity/group_entity.dart';
import 'package:expenseo/features/split/domain/entity/settle_balance.dart';
import 'package:expenseo/features/split/domain/use_case/split_use_case.dart';
import 'package:expenseo/features/split/presentation/cubit/split_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/storage/shared_pref/shared_pref_service.dart';
import '../../domain/entity/split_entity.dart';

class SplitCubit extends Cubit<SplitState> {
  final SplitUseCase useCase;
  SplitCubit(this.useCase) : super(SplitInitial());

  String get currentUid  => SharedPrefService.getUserId() ?? '';
  String get currentName => SharedPrefService.getUserName() ?? '';

  Future<void> searchUser(String email) async {
    emit(UserSearchLoading());
    try {
      final user = await useCase.searchUserByEmail(email);

      if (user == null) {
        emit(UserSearchNotFound());
        return;
      }

      if(user.uid==currentUid){
        emit(SplitError(AppString.youCanNotAddYourSelf));
        return;
      }

      emit(UserSearchResult(user: user));

    } catch (e) {
      emit(SplitError(e.toString()));
    }
  }

  Future<void> createGroup({
    required String name,
    required List<String> memberEmails,
  }) async {

    emit(SplitLoading());
    try{
      final request = CreateGroupRequest(
        name: name,
        memberEmails: memberEmails,
      );

      await useCase.createGroup(request);

      emit(SplitSuccess(AppString.groupCreated));
    }catch (e){
      emit(SplitError(e.toString()));
    }

  }

  Future<void> getGroups() async {
    emit(SplitLoading());
    try{
      final groups = await useCase.getGroups();
      emit(SplitLoaded(groups));
    }catch (e){
      emit(SplitError(e.toString()));
    }
  }

  Future<void> addSplitExpense(
      SplitEntity entity
  ) async {
    emit(SplitLoading());
    try {
      await useCase.addSplitExpense(entity);
      emit(SplitSuccess('Expense added!'));
    } catch (e) {
      emit(SplitError(e.toString()));
    }
  }

  Future<void> loadGroupDetail(GroupEntity group) async {
    emit(SplitLoading());
    try {

      final results = await Future.wait([
        useCase.getSplitExpense(group.id),
        useCase.getSettlements(group.id),
      ]);

      final expenses    = results[0] as List<SplitEntity>;
      final settlements = results[1] as List<SettleBalance>;
      emit(
        GroupDetailLoaded(group: group, expenses: expenses, settlements: settlements),
      );
    } catch (e) {
      emit(SplitError(e.toString()));
    }
  }

  Future<void> deleteGroup(String groupId) async {
    emit(SplitLoading());
    try {
      await useCase.deleteGroup(groupId);
      emit(SplitSuccess(AppString.groupDeleted));
      await getGroups();
    } catch (e) {
      emit(SplitError(e.toString()));
    }
  }

  Future<void> settleUp({
    required GroupEntity group,
    required String toUid,
    required String toName,
    required double amount,
  }) async {
    emit(SplitLoading());
    try {
      final settlement = SettleBalance(
        id:        const Uuid().v4(),
        groupId:   group.id,
        from:      currentUid,
        fromName:  currentName,
        to:        toUid,
        toName:    toName,
        amount:    amount,
        createdAt: DateTime.now(),
      );

      await useCase.settleUp(settlement);

      await loadGroupDetail(group);
      // emit(SplitSuccess(AppString.settleBalance));
    } catch (e) {
      emit(SplitError(e.toString()));
    }
  }
}
