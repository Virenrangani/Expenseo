import 'package:flutter/material.dart';

import '../../../../core/constant/border_radius/app_border_radius.dart';
import '../../../../core/constant/colour/app_color.dart';
import '../../../../core/constant/gap/app_gap.dart';
import '../../../../core/constant/padding/app_padding.dart';
import '../../../../core/constant/text_style/app_text_style.dart';

class GroupMemberTile extends StatelessWidget {
  final String name;
  final VoidCallback onRemove;

  const GroupMemberTile({super.key, required this.name, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: AppPadding.edgeAll12,
      decoration: BoxDecoration(
        color: AppColor.primaryLight,
        borderRadius: AppBorderRadius.cir12,
        border: Border.all(color: AppColor.primary.withAlpha(75)),
      ),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: const BoxDecoration(
              color: AppColor.primary,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                name[0].toUpperCase(),
                style: AppTextStyles.captionBold(color: AppColor.background),
              ),
            ),
          ),
          AppGap.g12,
          Expanded(
            child: Text(name, style: AppTextStyles.bodySmall(
                color: AppColor.textPrimary)),
          ),
          GestureDetector(
            onTap: onRemove,
            child: const Icon(
                Icons.close, size: 18, color: AppColor.textSecondary),
          ),
        ],
      ),
    );
  }
}