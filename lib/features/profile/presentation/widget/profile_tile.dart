import 'package:expenseo/core/constant/text_style/app_text_style.dart';
import 'package:flutter/material.dart';

import '../../../../core/constant/colour/app_color.dart';
import '../../../../core/constant/gap/app_gap.dart';

class SettingsTile extends StatelessWidget {
  final String title;
  final IconData leadingIcon;
  final Color? iconColor;
  final Widget? trailing;
  final VoidCallback onTap;
  final bool isDestructive;

  const SettingsTile({
    super.key,
    required this.title,
    required this.leadingIcon,
    required this.onTap,
    this.iconColor,
    this.trailing,
    this.isDestructive = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isDestructive
                    ? AppColor.error.withAlpha(25)
                    : (iconColor ?? AppColor.primary).withAlpha(25),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                leadingIcon,
                size: 20,
                color: isDestructive
                    ? AppColor.error
                    : (iconColor ?? AppColor.primary),
              ),
            ),
            AppGap.g16,
            Expanded(
              child: Text(
                title,
                style: AppTextStyles.bodySmall(
                  color: isDestructive ? AppColor.error : AppColor.textPrimary,
                ).copyWith(fontWeight: FontWeight.w500),
              ),
            ),
            trailing ??
                const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Colors.grey,
                  size: 14,
                ),
          ],
        ),
      ),
    );
  }
}
