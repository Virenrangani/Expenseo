import 'package:expenseo/features/investment/main_page/stocks/domain/entity/stock.dart';
import 'package:expenseo/features/investment/main_page/stocks/domain/use_case/stock_use_case.dart';
import 'package:expenseo/features/investment/main_page/stocks/presentation/cubit/stock_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StockCubit extends Cubit<StockState> {
  final StockUseCase stockUseCase;

  StockCubit(this.stockUseCase) : super(StockInitial()) {
    getAllStock();
  }

  Future<void> createStock(String stockId, Stock stock) async {
    emit(StockLoading());
    try {
      await stockUseCase.createStock(stockId, stock);

      emit(StockSuccess('Stock is added successfully..!!'));
      await getAllStock();
    } catch (e) {
      emit(StockError(e.toString()));
    }
  }

  Future<void> getAllStock() async {
    emit(StockLoading());
    try {
      final stocks = await stockUseCase.getAllStocks();

      emit(StockLoaded(stocks));
    } catch (e) {
      emit(StockError(e.toString()));
    }
  }

  Future<void> removeStock(String stockId) async {
    emit(StockLoading());
    try {
      await stockUseCase.removeStock(stockId);

      emit(StockSuccess('Stock Deleted Successfully..!!'));
      await getAllStock();
    } catch (e) {
      emit(StockError(e.toString()));
    }
  }
}
