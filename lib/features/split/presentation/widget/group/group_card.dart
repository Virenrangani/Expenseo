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
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: AppBorderRadius.cir20,
        border: Border.all(color: const Color(0xFFE8EEF8), width: 1.2),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF2A5CF6).withAlpha(12),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {
            final splitCubit = context.read<SplitCubit>();
            context.push(
              BlocProvider.value(
                value: splitCubit,
                child: GroupDetailsPage(group: group),
              ),
            );
          },
          child: Padding(
            padding: AppPadding.edgeAll16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    _buildGroupIconBadge(),
                    AppGap.g12,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            group.name,
                            style:
                                AppTextStyles.h4(
                                  color: const Color(0xFF1E293B),
                                ).copyWith(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 17,
                                ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          AppGap.g4,
                          Row(
                            children: [
                              const Icon(
                                Icons.calendar_today_rounded,
                                size: 12,
                                color: Color(0xFF94A3B8),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                _formatDate(group.createdAt),
                                style: AppTextStyles.descriptionSmall()
                                    .copyWith(
                                      color: const Color(0xFF64748B),
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    _buildDeleteButton(context),
                  ],
                ),

                AppGap.g16,
                const Divider(height: 1, color: Color(0xFFF1F5F9)),
                AppGap.g12,

                Row(
                  children: [
                    _buildOverlappingAvatars(group.memberNames.values.toList()),
                    AppGap.g12,
                    Expanded(
                      child: Text(
                        _memberPreview(group),
                        style: AppTextStyles.captionMedium(
                          color: const Color(0xFF475569),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 14,
                      color: Color(0xFFCBD5E1),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGroupIconBadge() {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF2A5CF6), Color(0xFF5C6CFF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF2A5CF6).withAlpha(40),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: const Center(
        child: Icon(Icons.groups_rounded, color: Colors.white, size: 22),
      ),
    );
  }

  Widget _buildDeleteButton(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () => _confirmDelete(context),
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColor.error.withAlpha(15),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Icon(
            Icons.delete_outline_rounded,
            size: 18,
            color: AppColor.error,
          ),
        ),
      ),
    );
  }

  void _confirmDelete(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (dialogCtx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Delete Group'),
        content: Text('Are you sure you want to delete "${group.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogCtx).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(dialogCtx).pop();
              await context.read<SplitCubit>().deleteGroup(group.id, context);
            },
            child: const Text(
              'Delete',
              style: TextStyle(color: AppColor.error),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOverlappingAvatars(List<String> names) {
    final displayNames = names.take(3).toList();
    final extraCount = names.length > 3 ? names.length - 3 : 0;

    return SizedBox(
      height: 30,
      width: (displayNames.length + (extraCount > 0 ? 1 : 0)) * 20.0 + 10,
      child: Stack(
        children: List.generate(
          displayNames.length + (extraCount > 0 ? 1 : 0),
          (index) {
            if (index == displayNames.length) {
              return Positioned(
                left: index * 20.0,
                child: _buildAvatarCircle(
                  '+$extraCount',
                  const Color(0xFFE2E8F0),
                  const Color(0xFF475569),
                ),
              );
            }

            final name = displayNames[index];
            final initial = name.isNotEmpty ? name[0].toUpperCase() : '?';

            final colors = [
              const Color(0xFF4F46E5),
              const Color(0xFF0EA5E9),
              const Color(0xFF10B981),
              const Color(0xFFF59E0B),
            ];
            final bgColor = colors[index % colors.length];

            return Positioned(
              left: index * 20.0,
              child: _buildAvatarCircle(initial, bgColor, Colors.white),
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
        border: Border.all(color: Colors.white, width: 2),
      ),
      child: CircleAvatar(
        radius: 13,
        backgroundColor: bgColor,
        child: Text(
          text,
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w700,
            color: textColor,
          ),
        ),
      ),
    );
  }

  String _memberPreview(GroupEntity group) {
    final names = group.memberNames.values.toList();
    if (names.isEmpty) return 'No members';
    if (names.length <= 2) return names.join(', ');
    return '${names.take(2).join(', ')} & ${names.length - 2} more';
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
