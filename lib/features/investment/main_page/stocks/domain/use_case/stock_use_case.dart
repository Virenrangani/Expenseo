import 'package:expenseo/features/investment/main_page/stocks/domain/repository/stock_repository.dart';

import '../entity/stock.dart';

class StockUseCase {
  final StockRepository stockRepository;

  StockUseCase(this.stockRepository);

  Future<void> createStock(Stock stock) {
    return stockRepository.createStock(stock);
  }
}
