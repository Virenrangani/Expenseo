import 'package:expenseo/features/investment/main_page/stocks/domain/entity/stock.dart';
import 'package:expenseo/features/investment/main_page/stocks/presentation/widget/profit_loss_chips.dart';
import 'package:expenseo/features/investment/main_page/stocks/presentation/widget/stock_price.dart';
import 'package:expenseo/features/investment/main_page/stocks/presentation/widget/stock_sector_chip.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/constant/colour/app_color.dart';
import '../../../../../../core/constant/gap/app_gap.dart';
import '../../../../../../core/constant/padding/app_padding.dart';
import '../../../../../../core/constant/text_style/app_text_style.dart';
import '../../../../../../core/widget/date_label/date_label.dart';

class StockCardBody extends StatefulWidget {
  final Stock stock;

  const StockCardBody({super.key, required this.stock});

  @override
  State<StockCardBody> createState() => _StockCardBodyState();
}

class _StockCardBodyState extends State<StockCardBody> {
  bool get _isProfit => widget.stock.sellPrice > widget.stock.buyPrice;

  Color get _pnlColor =>
      _isProfit ? const Color(0xFF63D2A3) : const Color(0xFFFF6B6B);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppPadding.edgeAll12,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              StockSectorChip(stockName: widget.stock.sector),
              AppGap.g8,
              Flexible(
                child: StockSectorChip(stockName: widget.stock.exchange),
              ),
            ],
          ),
          AppGap.g12,
          Divider(height: 0.5, color: AppColor.textSecondary.withAlpha(65)),
          AppGap.g12,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              StockPrice(
                label: 'Buy price',
                value: '₹${widget.stock.buyPrice.toStringAsFixed(2)}',
                valueColor: AppColor.background.withAlpha(100),
              ),
              Text(
                dateLabel(widget.stock.buyDate),
                style: AppTextStyles.captionMedium(),
              ),
            ],
          ),
          AppGap.g12,
          Divider(height: 0.5, color: AppColor.textSecondary.withAlpha(65)),
          AppGap.g12,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              StockPrice(
                label: 'Sell price',
                value: '₹${widget.stock.sellPrice.toStringAsFixed(2)}',
                valueColor: const Color(0xFF63D2A3),
              ),
              ProfitLossChips(
                value: widget.stock.profitLoss,
                isProfit: _isProfit,
                color: _pnlColor,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
