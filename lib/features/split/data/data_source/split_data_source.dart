import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expenseo/core/constant/string/app_string.dart';
import 'package:expenseo/core/error/app_errors.dart';
import 'package:expenseo/features/split/data/model/group_model.dart';
import 'package:expenseo/features/split/data/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

abstract class SplitDataSource {
  Future<void> createGroup(GroupModel group);
  Future<UserModel?> searchUserByEmail(String email);
  Future<List<GroupModel>> getGroups();
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
      debugPrint('GetGroups Error: $e');
      throw Exception(e.toString());
      // throw Exception(AppErrors.handleFireStoreException(e));
    } catch (e) {
      throw Exception(AppString.somethingWentWrong);
    }
  }

}


