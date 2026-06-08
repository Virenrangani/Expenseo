import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';

import '../../../../../../core/constant/border_radius/app_border_radius.dart';
import '../../../../../../core/constant/colour/app_color.dart';
import '../../../../../../core/constant/padding/app_padding.dart';
import '../../../../../../core/constant/text_style/app_text_style.dart';

class StockSectorChip extends StatelessWidget {
  final String sector;

  const StockSectorChip({super.key, required this.sector});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppPadding.edgeAll4,
      decoration: BoxDecoration(
        color: AppColor.background.withAlpha(15),
        borderRadius: AppBorderRadius.cir8,
      ),
      child: AutoSizeText(
        minFontSize: 10,
        maxLines: 2,
        sector.toUpperCase(),
        style: AppTextStyles.captionMedium(),
      ),
    );
  }
}
