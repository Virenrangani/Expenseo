import 'package:auto_size_text/auto_size_text.dart';
import 'package:expenseo/core/constant/border_radius/app_border_radius.dart';
import 'package:expenseo/core/constant/text_style/app_text_style.dart';
import 'package:flutter/cupertino.dart';

import '../../../../../../core/constant/colour/app_color.dart';
import '../../../../../../core/constant/padding/app_padding.dart';

class StockNameChip extends StatelessWidget {
  final String symbol;

  const StockNameChip({super.key, required this.symbol});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppPadding.edgeAll8,
      decoration: BoxDecoration(
        color: AppColor.success.withAlpha(40),
        borderRadius: AppBorderRadius.cir8,
        border: Border.all(color: AppColor.success.withAlpha(75)),
      ),
      child: AutoSizeText(
        maxLines: 1,
        symbol,
        style: AppTextStyles.captionBold(color: AppColor.success),
      ),
    );
  }
}
