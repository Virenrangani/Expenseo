import 'package:expenseo/core/constant/border_radius/app_border_radius.dart';
import 'package:expenseo/core/constant/gap/app_gap.dart';
import 'package:expenseo/features/investment/main_page/stocks/presentation/widget/sell_bottom_sheet.dart';
import 'package:expenseo/features/investment/main_page/stocks/presentation/widget/stock_action_button.dart';
import 'package:expenseo/features/investment/main_page/stocks/presentation/widget/stock_name_chip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/constant/colour/app_color.dart';
import '../../../../../../core/constant/padding/app_padding.dart';
import '../../domain/entity/stock.dart';
import '../cubit/stock_cubit.dart';

class StockCardHeader extends StatefulWidget {
  final Stock stock;

  const StockCardHeader({super.key, required this.stock});

  @override
  State<StockCardHeader> createState() => _StockCardHeaderState();
}

class _StockCardHeaderState extends State<StockCardHeader> {
  final TextEditingController amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppPadding.edgeAll12,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(child: StockNameChip(symbol: widget.stock.stockName)),
          Row(
            children: [
              StockActionButton(
                icon: Icons.sync_rounded,
                color: AppColor.success,
                bgColor: AppColor.success.withAlpha(40),
                borderColor: AppColor.success.withAlpha(75),
                onTap: () => _openSellDialog(context),
              ),
              AppGap.g12,
              StockActionButton(
                icon: Icons.delete_rounded,
                color: AppColor.error,
                bgColor: AppColor.error.withAlpha(30),
                borderColor: AppColor.error.withAlpha(65),
                onTap: () =>
                    context.read<StockCubit>().removeStock(widget.stock.id),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _openSellDialog(BuildContext context) {
    final stockCubit = context.read<StockCubit>();
    amountController.clear();
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: AppBorderRadius.verTop24),
      isScrollControlled: true,
      builder: (context) {
        return BlocProvider.value(
          value: stockCubit,
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: SellBottomSheet(
              controller: amountController,
              onConfirm: () {
                final val = double.tryParse(amountController.text);
                if (val != null) {
                  stockCubit.sellStock(widget.stock.id, val);
                  Navigator.pop(context);
                }
              },
            ),
          ),
        );
      },
    );
  }
}
