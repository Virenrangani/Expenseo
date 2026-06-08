import 'package:flutter/material.dart';

import '../../../../../../core/constant/border_radius/app_border_radius.dart';
import '../../../../../../core/constant/gap/app_gap.dart';

class ProfitLossChips extends StatelessWidget {
  final double? value;
  final bool isProfit;
  final Color color;

  const ProfitLossChips({
    super.key,
    required this.value,
    required this.isProfit,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    if (value == null) return const SizedBox.shrink();
    final display = isProfit
        ? '+₹${value!.abs().toStringAsFixed(2)}'
        : '-₹${value!.abs().toStringAsFixed(2)}';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withAlpha(40),
        borderRadius: AppBorderRadius.cir20,
        border: Border.all(color: color.withAlpha(70)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isProfit ? Icons.trending_up_rounded : Icons.trending_down_rounded,
            color: color,
            size: 13,
          ),
          AppGap.g4,
          Text(
            display,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
