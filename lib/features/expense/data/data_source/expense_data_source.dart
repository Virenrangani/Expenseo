import '../model/expense_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../core/error/app_errors.dart';
import '../../../../core/constant/string/app_string.dart';

abstract class ExpenseDataSource {
  Future<void> addExpense(String uid, ExpenseModel expense);
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
}
