import 'package:expenseo/core/navigation/app_navigation.dart';
import 'package:expenseo/features/split/presentation/page/group_details_page.dart';
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
    return GestureDetector(
      onTap: () {
        final splitCubit = context.read<SplitCubit>();
        context.push(
          BlocProvider.value(
            value: splitCubit,
            child: GroupDetailsPage(group: group),
          ),
        );
      },
      child: Container(
        padding: AppPadding.edgeAll16,
        decoration: BoxDecoration(
          color: AppColor.textPrimary,
          borderRadius: AppBorderRadius.cir16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildOverlappingAvatars(group.memberNames.values.toList()),

            AppGap.g16,

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    group.name,
                    style: AppTextStyles.h4(
                      color: AppColor.primary,
                    ).copyWith(fontWeight: FontWeight.w700),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    await context.read<SplitCubit>().deleteGroup(
                      group.id,
                      context,
                    );
                  },
                  child: Icon(
                    Icons.delete_outline,
                    color: AppColor.error.withAlpha(200),
                  ),
                ),
              ],
            ),

            AppGap.g16,

            _buildDataRow('Members:', _memberPreview(group)),
            AppGap.g12,
            _buildDataRow('Created:', _formatDate(group.createdAt)),
          ],
        ),
      ),
    );
  }

  Widget _buildDataRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 100,
          child: Text(
            label,
            style: AppTextStyles.bodySmall(
              color: AppColor.background,
            ).copyWith(fontWeight: FontWeight.w500),
          ),
        ),
        Expanded(
          child: Row(
            children: [
              if (label == 'Created:') ...[
                Container(
                  width: 6,
                  height: 6,
                  margin: const EdgeInsets.only(right: 6, top: 2),
                  decoration: const BoxDecoration(
                    color: Colors.deepOrange,
                    shape: BoxShape.circle,
                  ),
                ),
              ],
              Expanded(
                child: Text(
                  value,
                  style: AppTextStyles.bodySmall(
                    color: AppColor.background,
                  ).copyWith(fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildOverlappingAvatars(List<String> names) {
    final displayNames = names.take(4).toList();
    final extraCount = names.length > 4 ? names.length - 4 : 0;

    return SizedBox(
      height: 36,
      child: Stack(
        children: List.generate(
          displayNames.length + (extraCount > 0 ? 1 : 0),
          (index) {
            if (index == displayNames.length) {
              return Positioned(
                left: index * 24.0,
                child: _buildAvatarCircle(
                  '+$extraCount',
                  Colors.grey.shade300,
                  Colors.black87,
                ),
              );
            }

            final initial = displayNames[index].isNotEmpty
                ? displayNames[index][0].toUpperCase()
                : '?';

            final colorIndex =
                displayNames[index].codeUnitAt(0) % Colors.primaries.length;
            final bgColor = Colors.primaries[colorIndex].withAlpha(200);

            return Positioned(
              left: index * 24.0,
              child: _buildAvatarCircle(initial, bgColor, AppColor.background),
            );
          },
        ),
      ),
    );
  }

  Widget _buildAvatarCircle(String text, Color bgColor, Color textColor) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: AppColor.background, width: 2),
      ),
      child: CircleAvatar(
        radius: 16,
        backgroundColor: bgColor,
        child: Text(text, style: AppTextStyles.captionBold(color: textColor)),
      ),
    );
  }

  String _memberPreview(GroupEntity group) {
    final names = group.memberNames.values.toList();
    if (names.length <= 3) return names.join(', ');
    return '${names.take(3).join(', ')} +${names.length - 3}';
  }

  String _formatDate(DateTime date) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }
}
