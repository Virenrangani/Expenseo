import 'package:expenseo/core/constant/padding/app_padding.dart';
import 'package:flutter/cupertino.dart';

import '../../../../../core/constant/border_radius/app_border_radius.dart';
import '../../../../../core/constant/colour/app_color.dart';
import '../../../../../core/constant/gap/app_gap.dart';
import '../../../../../core/constant/text_style/app_text_style.dart';
import '../../../domain/entity/group_entity.dart';

class PaidBySelector extends StatelessWidget {
  final GroupEntity group;
  final String selectedUid;
  final void Function(String uid, String name) onChanged;

  const PaidBySelector({super.key,
    required this.group,
    required this.selectedUid,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: group.members.map((uid) {

          final name  = group.memberNames[uid] ?? '';
          final isSelected = selectedUid == uid;

          return GestureDetector(
            onTap: () => onChanged(uid, name),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              margin: const EdgeInsets.only(right: 8),
              padding: AppPadding.edgeAll12,
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColor.primary.withAlpha(25)
                    : AppColor.background,
                borderRadius: AppBorderRadius.cir12,
                border: Border.all(
                  color: isSelected
                      ? AppColor.primary
                      : AppColor.divider,
                  width: isSelected ? 1.5 : 0.5,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 26,
                    height: 26,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColor.primary
                          : AppColor.primaryLight,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        name[0].toUpperCase(),
                        style: isSelected ?
                        AppTextStyles.captionBold(color: AppColor.textSecondary)
                            : AppTextStyles.description()
                      ),
                    ),
                  ),
                  AppGap.g8,
                  Text(name,
                      style: isSelected ?
                      AppTextStyles.captionBold()
                          : AppTextStyles.description()
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}