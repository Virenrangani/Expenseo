import 'package:expenseo/features/split/presentation/page/group_details_page.dart';
import 'package:expenseo/features/split/presentation/widget/group/group_avatar.dart';
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
      onTap: (){
        final splitCubit=context.read<SplitCubit>();
        Navigator.push(context,
            MaterialPageRoute<void>(
                builder: (context)=>  BlocProvider.value(
                value: splitCubit,
                child:  GroupDetailsPage(group: group,),
              )
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
            IconButton(onPressed: ()async{
              await context.read<SplitCubit>().deleteGroup(group.id);
            }, icon: const Icon(Icons.delete))
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