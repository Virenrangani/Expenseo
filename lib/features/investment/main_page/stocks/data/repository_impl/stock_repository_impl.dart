import 'package:expenseo/features/investment/main_page/stocks/data/data_source/stock_data_source.dart';
import 'package:expenseo/features/investment/main_page/stocks/data/model/stock_model.dart';
import 'package:expenseo/features/investment/main_page/stocks/domain/entity/stock.dart';
import 'package:expenseo/features/investment/main_page/stocks/domain/repository/stock_repository.dart';

class StockRepositoryImpl extends StockRepository {
  final StockDataSource stockDataSource;

  StockRepositoryImpl(this.stockDataSource);

  @override
  Future<void> createStock(Stock stock) async {
    await stockDataSource.createStock(StockModel.fromEntity(stock));
  }

  @override
  Future<List<Stock>> getAllStocks() async {
    final stocks = await stockDataSource.getAllStock();

    return stocks.map(StockModel.toEntity).toList();
  }
}
