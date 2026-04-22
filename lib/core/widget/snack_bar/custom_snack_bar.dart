import 'package:expenseo/core/constant/border_radius/app_border_radius.dart';
import 'package:expenseo/core/constant/text_style/app_text_style.dart';
import 'package:flutter/material.dart';

import '../../constant/colour/app_color.dart';
import '../../constant/gap/app_gap.dart';

class CustomSnacksBar {
  static void showSuccess(BuildContext context, String message) {
    showSnackBar(
      context,
      message,
      backgroundColor: AppColor.success,
      icon: Icons.check_circle,
    );
  }

  static void showError(BuildContext context, String message) {
    showSnackBar(
      context,
      message,
      backgroundColor: AppColor.error,
      icon: Icons.error,
    );
  }

  static void showInfo(BuildContext context, String message) {
    showSnackBar(
      context,
      message,
      backgroundColor: AppColor.info,
      icon: Icons.info,
    );
  }

  static void showSnackBar(
    BuildContext context,
    String message, {
    required Color backgroundColor,
    required IconData icon,
  }) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: backgroundColor,
        elevation: 6,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(borderRadius: AppBorderRadius.cir16),
        duration: const Duration(seconds: 3),
        content: Row(
          children: [
            Icon(icon, color: AppColor.secondary),
            AppGap.g12,
            Expanded(
              child: Text(
                message,
                style: AppTextStyles.bodySmall(color: AppColor.textPrimary),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
