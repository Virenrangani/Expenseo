import 'package:flutter/cupertino.dart';

import '../../../../../core/constant/border_radius/app_border_radius.dart';
import '../../../../../core/constant/colour/app_color.dart';
import '../../../../../core/constant/text_style/app_text_style.dart';
import '../../../domain/entity/group_entity.dart';

class GroupAvatar extends StatelessWidget {
  final GroupEntity group;

  const GroupAvatar({super.key, required this.group});

  @override
  Widget build(BuildContext context) {
    return  Container(
      width:  48,
      height: 48,
      decoration: BoxDecoration(
        color: AppColor.primaryLight,
        borderRadius: AppBorderRadius.cir12,
      ),
      child: Center(
        child: Text(
          group.name[0].toUpperCase(),
          style: AppTextStyles.h4(color: AppColor.secondary),
        ),
      ),
    );
  }
}
