import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expenseo/features/investment/main_page/stocks/data/model/stock_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../../../core/constant/string/app_string.dart';
import '../../../../../../core/error/app_errors.dart';

abstract class StockDataSource {
  Future<void> createStock(String stockId, StockModel stockModel);

  Future<List<StockModel>> getAllStock();

  Future<void> removeStock(String stockId);
}

class StockDataSourceImpl extends StockDataSource {
  final FirebaseFirestore firestore;
  final FirebaseAuth firebaseAuth;

  StockDataSourceImpl(this.firestore, this.firebaseAuth);

  final userId = FirebaseAuth.instance.currentUser?.uid;

  @override
  Future<void> createStock(String stockId, StockModel stockModel) async {
    try {
      await firestore
          .collection('users')
          .doc(userId)
          .collection('investment')
          .add(stockModel.toJson());
    } on FirebaseException catch (e) {
      throw Exception(AppErrors.handleFireStoreException(e));
    } catch (e) {
      throw Exception(AppString.somethingWentWrong);
    }
  }

  @override
  Future<List<StockModel>> getAllStock() async {
    try {
      final stocks = await firestore
          .collection('users')
          .doc(userId)
          .collection('investment')
          .get();

      return stocks.docs.map((e) => StockModel.fromJson(e.data())).toList();
    } on FirebaseException catch (e) {
      throw Exception(AppErrors.handleFireStoreException(e));
    } catch (e) {
      throw Exception(AppString.somethingWentWrong);
    }
  }

  @override
  Future<void> removeStock(String stockId) async {
    try {
      await firestore
          .collection('users')
          .doc(userId)
          .collection('investment')
          .doc(stockId)
          .delete();
    } on FirebaseException catch (e) {
      throw Exception(AppErrors.handleFireStoreException(e));
    } catch (e) {
      throw Exception(AppString.somethingWentWrong);
    }
  }
}
