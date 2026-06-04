import 'package:expenseo/features/investment/main_page/stocks/domain/entity/stock.dart';

abstract class StockRepository {
  Future<void> createStock(String stockId, Stock stock);

  Future<List<Stock>> getAllStocks();

  Future<void> removeStock(String stockId);
}
