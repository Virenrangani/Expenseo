import 'package:expenseo/features/investment/main_page/stocks/domain/entity/stock.dart';

abstract class StockState {}

class StockInitial extends StockState {}

class StockLoading extends StockState {}

class StockError extends StockState {
  final String message;

  StockError(this.message);
}

class StockSuccess extends StockState {
  final String message;

  StockSuccess(this.message);
}

class StockLoaded extends StockState {
  final List<Stock> stocks;

  StockLoaded(this.stocks);
}
