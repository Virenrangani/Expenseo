import 'package:flutter/material.dart';

import '../../../../core/constant/colour/app_color.dart';
import '../../../../core/constant/padding/app_padding.dart';

class SideButton extends StatelessWidget {
  final IconData iconData;
  final VoidCallback? onTap;

  const SideButton({super.key, required this.iconData, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: AppPadding.edgeAll8,
          child: Container(
            height: 68,
            width: 68,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                width: 2,
                color: AppColor.textLight.withAlpha(100),
              ),
            ),
            child: Icon(iconData, size: 32, color: AppColor.background),
          ),
        ),
      ),
    );
  }
}
