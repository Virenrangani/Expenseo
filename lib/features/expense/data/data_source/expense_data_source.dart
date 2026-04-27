import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/constant/string/app_string.dart';
import '../../../../core/error/app_errors.dart';
import '../model/expense_model.dart';

abstract class ExpenseDataSource {
  Future<void> addExpense(String uid, ExpenseModel expense);
  Future<List<ExpenseModel>> getExpense(String uid);
}

class ExpenseDataSourceImpl implements ExpenseDataSource{
  final FirebaseFirestore firestore;

  ExpenseDataSourceImpl(this.firestore);

  @override
  Future<void> addExpense(String uid, ExpenseModel expense) async {
    try{
      await firestore
          .collection('users')
          .doc(uid)
          .collection('expenses')
          .add(expense.toJson());
    }on FirebaseException catch (e){
      throw Exception(AppErrors.handleFireStoreException(e));
    }catch (e){
      throw Exception(AppString.somethingWentWrong);
    }
  }

  @override
  Future<List<ExpenseModel>> getExpense(String uid) async {
    await Future<void>.delayed(const Duration(seconds: 2));
    try{
      final expense=await firestore
          .collection('users')
          .doc(uid)
          .collection('expenses')
          .get();
      return expense.docs.map((e)=>
          ExpenseModel.fromJson(e.id,e.data())).toList();
    }on FirebaseException catch(e){
      throw Exception(AppErrors.handleFireStoreException(e));
    }catch(e){
      throw Exception(AppString.somethingWentWrong);
    }
  }
}
