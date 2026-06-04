import 'package:expenseo/features/investment/main_page/stocks/domain/entity/stock.dart';
import 'package:expenseo/features/investment/main_page/stocks/presentation/widget/stock_list_tile.dart';
import 'package:flutter/cupertino.dart';

class StockDetailPage extends StatelessWidget {
  final List<Stock> stocks;

  const StockDetailPage({super.key, required this.stocks});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: stocks.length,

      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.78,
      ),
      itemBuilder: (context, index) {
        return StockListTile(stock: stocks[index]);
      },
    );
  }
}
