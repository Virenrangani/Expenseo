import 'package:expenseo/features/investment/main_page/stocks/domain/repository/stock_repository.dart';

import '../entity/stock.dart';

class StockUseCase {
  final StockRepository stockRepository;

  StockUseCase(this.stockRepository);

  Future<void> createStock(String stockId, Stock stock) {
    return stockRepository.createStock(stockId, stock);
  }

  Future<List<Stock>> getAllStocks() {
    return stockRepository.getAllStocks();
  }

  Future<void> removeStock(String stockId) {
    return stockRepository.removeStock(stockId);
  }

  Future<void> sellStock(String stockId, double sellPrice) {
    return stockRepository.sellStock(stockId, sellPrice);
  }
}
