import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expenseo/core/constant/string/app_string.dart';
import 'package:expenseo/core/error/app_errors.dart';
import 'package:expenseo/features/split/data/model/group_model.dart';
import 'package:expenseo/features/split/data/model/settle_balance_model.dart';
import 'package:expenseo/features/split/data/model/split_model.dart';
import 'package:expenseo/features/split/data/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class SplitDataSource {
  Future<void> createGroup(GroupModel group);
  Future<UserModel?> searchUserByEmail(String email);
  Future<List<GroupModel>> getGroups();
  Future<void> addSplitExpense(SplitModel expense);
  Future<List<SplitModel>> getSplitExpenses(String groupId);
  Future<void> deleteGroup(String groupId);
  Future<void> settleUp(SettleBalanceModel settlement);
  Future<List<SettleBalanceModel>> getSettlements(String groupId);
}

class SplitDataSourceImpl implements SplitDataSource {
  final FirebaseFirestore firestore;

  SplitDataSourceImpl(this.firestore,);

  String get uid => FirebaseAuth.instance.currentUser!.uid;

  @override
  Future<void> createGroup(GroupModel group) async {
    try {
      await firestore.collection('groups')
          .doc(group.id)
          .set(group.toJson());
    } on FirebaseException catch (e) {
      throw Exception(AppErrors.handleFireStoreException(e));
    } catch (e) {
      throw Exception(AppString.somethingWentWrong);
    }
  }

  @override
  Future<UserModel?> searchUserByEmail(String email) async {
    try {
      final snap = await firestore
          .collection('users')
          .where('email', isEqualTo: email.trim().toLowerCase())
          .limit(1)
          .get();

      if (snap.docs.isEmpty) return null;

      final doc = snap.docs.first;

      return UserModel.fromFirestore(doc.data(), doc.id);

    } on FirebaseException catch (e) {
      throw Exception(AppErrors.handleFireStoreException(e));

    }catch (e){
      throw Exception(AppString.somethingWentWrong);
    }
  }

  @override
  Future<List<GroupModel>> getGroups() async {
    try {
      final groups = await firestore
          .collection('groups')
          .where('members', arrayContains: uid)
          .orderBy('createdAt', descending: true)
          .get();

      return groups.docs.map((doc) {
        return GroupModel.fromJson({
          ...doc.data(),
          'id': doc.id,
        });
      }).toList();

    } on FirebaseException catch (e) {
      throw Exception(AppErrors.handleFireStoreException(e));
    } catch (e) {
      throw Exception(AppString.somethingWentWrong);
    }
  }

  @override
  Future<void> addSplitExpense(SplitModel expense) async{
    try{
       await firestore.collection('groups')
          .doc(expense.groupId)
          .collection('expense')
          .add(expense.toJson());

    } on FirebaseException catch (e) {
      throw Exception(AppErrors.handleFireStoreException(e));
    } catch (e) {
      throw Exception(AppString.somethingWentWrong);
    }
  }

  @override
  Future<List<SplitModel>> getSplitExpenses(String groupId) async {
    try{

      final splitExpense = await firestore.collection('groups')
          .doc(groupId)
          .collection('expense')
          .orderBy('createdAt', descending: true)
          .get();

      return splitExpense.docs.map(
              (e)=> SplitModel.fromJson(e.data(), e.id)
      ).toList();

    }on FirebaseException catch (e) {
      throw Exception(AppErrors.handleFireStoreException(e));
    } catch (e) {
      throw Exception(AppString.somethingWentWrong);
    }
  }

  @override
  Future<void> deleteGroup(String groupId) async{

    try{

      final groupExpense = await firestore.collection('groups')
          .doc(groupId).collection('expense')
          .get();

      for (final doc in groupExpense.docs) {
        await doc.reference.delete();
      }

      final groupSettlement = await firestore.collection('groups')
          .doc(groupId).collection('settlements')
          .get();

      for (final doc in groupSettlement.docs) {
        await doc.reference.delete();
      }

      await firestore.collection('groups').doc(groupId).delete();

    }on FirebaseException catch (e) {
      throw Exception(AppErrors.handleFireStoreException(e));
    } catch (e) {
      throw Exception(AppString.somethingWentWrong);
    }
  }

  @override
  Future<void> settleUp(SettleBalanceModel settlement) async {
    try{
      await firestore.collection('groups')
          .doc(settlement.groupId)
          .collection('settlements')
          .add(settlement.toJson()
      );
    } on FirebaseException catch (e) {
      throw Exception(AppErrors.handleFireStoreException(e));
    } catch (e) {
      throw Exception(AppString.somethingWentWrong);
    }
  }

  @override
  Future<List<SettleBalanceModel>> getSettlements(String groupId) async {
    try {
      final settlement = await firestore.collection('groups')
          .doc(groupId)
          .collection('settlements')
          .orderBy('createdAt',descending: true).get();
      
      return settlement.docs.map(
              (e)=> SettleBalanceModel.fromJson(
                  e.id,
                e.data()
              )
      ).toList();

    } on FirebaseException catch (e) {
      throw Exception(AppErrors.handleFireStoreException(e));
    } catch (e) {
      throw Exception(AppString.somethingWentWrong);
    }
  }

}


