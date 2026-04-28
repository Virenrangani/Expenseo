import 'package:expenseo/core/constant/padding/app_padding.dart';
import 'package:expenseo/core/constant/text_style/app_text_style.dart';
import 'package:flutter/material.dart';

class OrDivider extends StatelessWidget {
  final String text;
  final Color lineColor;
  final double thickness;

   const OrDivider({
    super.key,
    this.text = "OR",
    this.lineColor =Colors.black26,
    this.thickness = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Divider(
            color: lineColor,
            thickness: thickness,
          ),
        ),
        Padding(
          padding: AppPadding.edgeSymmetricHori12,
          child: Text(
            text,
            style: AppTextStyles.bodyMedium()
          ),
        ),
        Expanded(
          child: Divider(
            color: lineColor,
            thickness: thickness,
          ),
        ),
      ],
    );
  }
}