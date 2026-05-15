import 'package:expenseo/core/constant/gap/app_gap.dart';
import 'package:flutter/material.dart';

import '../../../../../core/constant/colour/app_color.dart';
import '../../../../../core/constant/text_style/app_text_style.dart';
import '../../../domain/entity/group_entity.dart';

class MemberRow extends StatelessWidget {
  final GroupEntity group;

  const MemberRow({
    super.key,
    required this.group,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height:80,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: group.memberNames.entries.map((entry) {
          return Container(
            margin: const EdgeInsets.only(right: 8),
            child: Column(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color:  AppColor.primary.withAlpha(40),
                    shape:  BoxShape.circle,
                    border: Border.all(
                        color: AppColor.primary.withAlpha(75)),
                  ),
                  child: Center(
                    child: Text(
                      entry.value[0].toUpperCase(),
                      style: AppTextStyles.captionBold(),
                    ),
                  ),
                ),
                AppGap.g8,
                Text(entry.value ,
                  style: AppTextStyles.bodyMedium(color: AppColor.textPrimary),overflow: TextOverflow.ellipsis,
                )
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}