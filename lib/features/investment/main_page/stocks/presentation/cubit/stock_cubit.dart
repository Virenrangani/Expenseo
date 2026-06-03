import 'package:expenseo/features/investment/main_page/stocks/domain/entity/stock.dart';
import 'package:expenseo/features/investment/main_page/stocks/domain/use_case/stock_use_case.dart';
import 'package:expenseo/features/investment/main_page/stocks/presentation/cubit/stock_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StockCubit extends Cubit<StockState> {
  final StockUseCase stockUseCase;

  StockCubit(this.stockUseCase) : super(StockInitial());

  Future<void> createStock(Stock stock) async {
    emit(StockLoading());
    try {
      await stockUseCase.createStock(stock);

      emit(StockSuccess('Stock is added successfully..!!'));
    } catch (e) {
      emit(StockError(e.toString()));
    }
  }
}
