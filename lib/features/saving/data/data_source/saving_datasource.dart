import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expenseo/features/saving/data/model/deposit_model.dart';
import 'package:expenseo/features/saving/data/model/saving_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/constant/string/app_string.dart';
import '../../../../core/error/app_errors.dart';

abstract class SavingDatasource {
  Future<void> createGoal(SavingModel savingGoal);
  Future<List<SavingModel>> getAllGoal();
  Future<void> addSavingAmount(DepositModel depositModel);
  Future<List<DepositModel>> getAllDeposit(String goalId);
}

class SavingDatasourceImpl extends SavingDatasource{
  final FirebaseFirestore firestore;
  final FirebaseAuth  auth;

  SavingDatasourceImpl(this.firestore,this.auth);

  String get uid => auth.currentUser!.uid;

  @override
  Future<void> createGoal(SavingModel savingGoal) async{
    try {
      await firestore.collection('users')
          .doc(uid)
          .collection('saving')
          .doc(savingGoal.id)
          .set(savingGoal.toJson());

    }on FirebaseException catch (e){
      throw Exception(AppErrors.handleFireStoreException(e));
    }catch (e){
      throw Exception(AppString.somethingWentWrong);
    }
  }

  @override
  Future<List<SavingModel>> getAllGoal() async{
    try{
      final goals = await firestore.collection('users')
          .doc(uid)
          .collection('saving')
          .orderBy('createdAt',descending: true)
          .get();

      return goals.docs.map((e)=> SavingModel.fromJson(
          e.id, e.data()
      )).toList();

    }on FirebaseException catch (e){
      throw Exception(AppErrors.handleFireStoreException(e));
    }catch (e){
      throw Exception(AppString.somethingWentWrong);
    }
  }

  @override
  Future<void> addSavingAmount(DepositModel depositModel)async {
    try{
      final goalStore = firestore.collection('users')
          .doc(uid)
          .collection('saving')
          .doc(depositModel.goalId);

      final depositStore = goalStore
          .collection('deposit')
          .doc(depositModel.id);

      await firestore.runTransaction(
          (transaction) async {
            final goal = await transaction.get(goalStore);

            if(!goal.exists){
              throw Exception('Goal is not found');
            }

            final data = goal.data();

            final savedAmount = (data?['savedAmount'] as num).toDouble();
            final targetAmount = (data?['targetAmount'] as num).toDouble();

            final newTotalAmount = savedAmount + depositModel.amount;

            final isCompleted = newTotalAmount >= targetAmount;

            transaction.update(goalStore, {
              'savedAmount':newTotalAmount,
              'isCompleted':isCompleted
            });

            transaction.set(depositStore, depositModel.toJson());

          }
      );


    }on FirebaseException catch (e){
      throw Exception(AppErrors.handleFireStoreException(e));
    }catch (e){
      throw Exception(AppString.somethingWentWrong);
    }
  }

  @override
  Future<List<DepositModel>> getAllDeposit(String goalId) async{
    try{
      final depositStore = firestore.collection('users')
          .doc(uid)
          .collection('saving')
          .doc(goalId)
          .collection('deposit');

      final deposits =await depositStore
          .orderBy('createdAt',descending: true)
          .get();

      return deposits.docs.map((e)=> DepositModel.fromJson(e.id, e.data())).toList();

    }on FirebaseException catch (e){
      throw Exception(AppErrors.handleFireStoreException(e));
    }catch (e){
      throw Exception(AppString.somethingWentWrong);
    }
  }
}
