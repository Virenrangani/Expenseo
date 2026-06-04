import 'package:expenseo/core/constant/border_radius/app_border_radius.dart';
import 'package:expenseo/core/constant/colour/app_color.dart';
import 'package:expenseo/core/constant/gap/app_gap.dart';
import 'package:expenseo/core/constant/padding/app_padding.dart';
import 'package:expenseo/core/constant/text_style/app_text_style.dart';
import 'package:expenseo/core/widget/date_label/date_label.dart';
import 'package:expenseo/features/investment/main_page/stocks/domain/entity/stock.dart';
import 'package:expenseo/features/investment/main_page/stocks/presentation/cubit/stock_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StockListTile extends StatelessWidget {
  final Stock stock;

  const StockListTile({super.key, required this.stock});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Stack(
        fit: StackFit.expand,
        children: [
          ClipRRect(
            borderRadius: AppBorderRadius.cir24,
            child: ShaderMask(
              shaderCallback: (bounds) {
                return const LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Colors.black, Colors.black54, Colors.transparent],
                ).createShader(bounds);
              },
              blendMode: BlendMode.darken,
              child: Image.network(stock.stockSymbol, fit: BoxFit.cover),
            ),
          ),

          Padding(
            padding: AppPadding.edgeAll16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  stock.stockName,
                  style: AppTextStyles.h4(color: AppColor.background),
                ),

                Row(
                  children: [
                    Text(
                      stock.sector,
                      style: AppTextStyles.captionBold(
                        color: AppColor.background,
                      ),
                    ),

                    AppGap.g8,

                    Expanded(
                      child: Text(
                        stock.exchange,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.captionBold(
                          color: AppColor.background,
                        ),
                      ),
                    ),
                  ],
                ),

                const Divider(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      stock.buyPrice.toString(),
                      style: AppTextStyles.titleMedium(),
                    ),
                    Text(
                      dateLabel(stock.buyDate),
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.caption(color: AppColor.background),
                    ),
                  ],
                ),
              ],
            ),
          ),

          Positioned(
            right: 5,
            top: 5,
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: AppColor.primary,
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.update, color: AppColor.background),
                  ),
                ),
                AppGap.g4,
                CircleAvatar(
                  backgroundColor: AppColor.primary,
                  child: IconButton(
                    onPressed: () {
                      context.read<StockCubit>().removeStock(stock.id);
                    },
                    icon: const Icon(Icons.delete, color: AppColor.background),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
