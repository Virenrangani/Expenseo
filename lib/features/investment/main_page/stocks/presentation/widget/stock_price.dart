import 'package:flutter/cupertino.dart';

import '../../../../../../core/constant/gap/app_gap.dart';
import '../../../../../../core/constant/text_style/app_text_style.dart';

class StockPrice extends StatelessWidget {
  final String label, value;
  final Color valueColor;

  const StockPrice({
    super.key,
    required this.label,
    required this.value,
    required this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label.toUpperCase(), style: AppTextStyles.captionMedium()),
        AppGap.g4,
        Text(value, style: AppTextStyles.titleMedium(color: valueColor)),
      ],
    );
  }
}
