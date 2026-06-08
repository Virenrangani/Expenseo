import 'package:expenseo/core/constant/border_radius/app_border_radius.dart';
import 'package:expenseo/features/investment/main_page/stocks/domain/entity/stock.dart';
import 'package:expenseo/features/investment/main_page/stocks/presentation/widget/stock_card_body.dart';
import 'package:expenseo/features/investment/main_page/stocks/presentation/widget/stock_card_header.dart';
import 'package:flutter/material.dart';

class StockListTile extends StatelessWidget {
  final Stock stock;

  const StockListTile({super.key, required this.stock});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        borderRadius: AppBorderRadius.cir20,
        color: const Color(0xFF0F1923),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StockCardHeader(stock: stock),
          StockCardBody(stock: stock),
        ],
      ),
    );
  }
}
