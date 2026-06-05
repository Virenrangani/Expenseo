import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expenseo/features/investment/main_page/stocks/data/model/stock_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../../../core/constant/string/app_string.dart';
import '../../../../../../core/error/app_errors.dart';

abstract class StockDataSource {
  Future<void> createStock(String stockId, StockModel stockModel);

  Future<List<StockModel>> getAllStock();

  Future<void> removeStock(String stockId);

  Future<void> sellStock(String stockId, double sellPrice);
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

      return stocks.docs
          .map((e) => StockModel.fromJson(e.id, e.data()))
          .toList();
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

  @override
  Future<void> sellStock(String stockId, double sellPrice) async {
    try {
      final stockDoc = await firestore
          .collection('users')
          .doc(userId)
          .collection('investment')
          .doc(stockId)
          .get();

      if (!stockDoc.exists) {
        throw Exception('Stock not found');
      }

      final data = stockDoc.data()!;

      final buyPrice = (data['buy_price'] as num).toDouble();
      final quantity = (data['quantity'] as num).toDouble();

      final profitLoss = (sellPrice - buyPrice) * quantity;

      await firestore
          .collection('users')
          .doc(userId)
          .collection('investment')
          .doc(stockId)
          .update({'sell_price': sellPrice, 'profit_loss': profitLoss});
    } on FirebaseException catch (e) {
      throw Exception(AppErrors.handleFireStoreException(e));
    } catch (e) {
      throw Exception(AppString.somethingWentWrong);
    }
  }
}
