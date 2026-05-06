import 'package:expenseo/core/constant/string/app_string.dart';
import 'package:expenseo/features/split/domain/entity/group_entity.dart';
import 'package:expenseo/features/split/domain/use_case/split_use_case.dart';
import 'package:expenseo/features/split/presentation/cubit/split_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import '../../domain/entity/split_entity.dart';

class SplitCubit extends Cubit<SplitState> {
  final SplitUseCase useCase;
  SplitCubit(this.useCase) : super(SplitInitial());

  String get currentUid  => FirebaseAuth.instance.currentUser!.uid;
  String get currentName => FirebaseAuth.instance.currentUser!.displayName ?? '';

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
    required List<String> memberUids,
    required Map<String, String> memberNames,
  }) async {
    emit(SplitLoading());
    try {
      final allUids  = [currentUid, ...memberUids];
      final allNames = {currentUid: currentName, ...memberNames};

      final group = GroupEntity(
        id: const Uuid().v4(),
        name: name,
        createdBy: currentUid,
        members: allUids,
        memberNames: allNames,
        createdAt: DateTime.now(),
      );

      await useCase.createGroup(group);
      emit(SplitSuccess(AppString.groupCreated));
    } catch (e) {
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
}
