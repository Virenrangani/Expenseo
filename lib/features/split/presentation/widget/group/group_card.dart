import 'package:expenseo/core/constant/string/app_string.dart';
import 'package:expenseo/core/widget/format_amount/format_amount.dart';
import 'package:expenseo/features/split/presentation/page/group_details_page.dart';
import 'package:expenseo/features/split/presentation/widget/group/group_avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constant/border_radius/app_border_radius.dart';
import '../../../../../core/constant/colour/app_color.dart';
import '../../../../../core/constant/gap/app_gap.dart';
import '../../../../../core/constant/padding/app_padding.dart';
import '../../../../../core/constant/text_style/app_text_style.dart';
import '../../../domain/entity/group_entity.dart';
import '../../cubit/split_cubit.dart';

class GroupCard extends StatelessWidget {
  final GroupEntity group;
  const GroupCard({super.key, required this.group});

  @override
  Widget build(BuildContext context) {
    final uid = context.read<SplitCubit>().currentUid;
    final balance = group.yourBalance(uid);

    return GestureDetector(
      onTap: (){
        Navigator.push(context,
            MaterialPageRoute<void>(
                builder: (context)=>const GroupDetailsPage()
            )
        );
      },
      child: Container(
        padding: AppPadding.edgeAll12,
        decoration: BoxDecoration(
          color: AppColor.background,
          borderRadius: AppBorderRadius.cir16,
          border: Border.all(color: AppColor.divider.withAlpha(100)),
        ),
        child: Row(
          children: [
           GroupAvatar(group: group),

            AppGap.g12,

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(group.name,
                      style: AppTextStyles.bodySmall(
                          color: AppColor.textPrimary)
                          .copyWith(fontWeight: FontWeight.w500)),
                  AppGap.g4,
                  Text(
                    _memberPreview(group),
                    style: AppTextStyles.descriptionSmall(),
                  ),
                ],
              ),
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  balance == 0
                      ? AppString.settled
                      : '${balance > 0 ? '+' : '-'}₹${formatAmount(balance.abs())}',
                  style: AppTextStyles.captionBold(
                    color: balance == 0
                        ? AppColor.textSecondary
                        : balance > 0
                        ? AppColor.success
                        : AppColor.error,
                  ),
                ),
                AppGap.g4,
                Text(
                  balance == 0
                      ? ''
                      : balance > 0 ? AppString.youOwed : AppString.owe,
                  style: AppTextStyles.descriptionSmall(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _memberPreview(GroupEntity group) {
    final names = group.memberNames.values.toList();
    if (names.length <= 3) return names.join(', ');
    return '${names.take(3).join(', ')} +${names.length - 3}';
  }

}