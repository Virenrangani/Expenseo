import 'package:flutter/material.dart';
import '../../constant/border_radius/app_border_radius.dart';
import '../../constant/padding/app_padding.dart';
import '../../constant/colour/app_color.dart';
import '../../constant/gap/app_gap.dart';
import '../../constant/text_style/app_text_style.dart';

class AppIconCard extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback? onTap;

  const AppIconCard({
    super.key,
    required this.icon,
    required this.text,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius:AppBorderRadius.cir16,
      child: Container(
        padding: AppPadding.edgeAll12,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: AppBorderRadius.cir16,
          boxShadow: [
            BoxShadow(
              blurRadius: 8,
              offset: Offset(0, 4),
              color: Colors.black.withOpacity(0.1),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size:24,
              color: AppColor.secondary,
            ),
            AppGap.g12,
            Text(
              text,
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyMedium()
            ),
          ],
        ),
      ),
    );
  }
}