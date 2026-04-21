import 'package:expenseo/core/constant/padding/app_padding.dart';
import 'package:flutter/material.dart';

class OrDivider extends StatelessWidget {
  final String text;
  final Color lineColor;
  final double thickness;

   OrDivider({
    super.key,
    this.text = "OR",
    this.lineColor =Colors.black45,
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
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
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