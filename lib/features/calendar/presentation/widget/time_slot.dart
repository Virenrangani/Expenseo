import 'package:expenseo/core/constant/border_radius/app_border_radius.dart';
import 'package:expenseo/core/constant/padding/app_padding.dart';
import 'package:expenseo/core/constant/text_style/app_text_style.dart';
import 'package:flutter/material.dart';

class TimeSlot extends StatelessWidget {
  final String label;
  final bool hasBlock;

  const TimeSlot({super.key, required this.label, this.hasBlock = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppPadding.edgeAll4,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 48,
            child: Text(
              label,
              style: AppTextStyles.bodySmall()
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(8),
              height: 32,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: AppBorderRadius.cir8,
                border: Border.all(color: Colors.grey.shade200),
              ),
            )
          ),
        ],
      ),
    );
  }
}