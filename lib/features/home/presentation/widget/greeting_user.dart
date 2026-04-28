import 'package:flutter/material.dart';

import '../../../../core/constant/colour/app_color.dart';
import '../../../../core/constant/gap/app_gap.dart';
import '../../../../core/constant/string/app_string.dart';
import '../../../../core/constant/text_style/app_text_style.dart';

class GreetingUser extends StatelessWidget {
  final String userName;

  const GreetingUser({
    super.key,
    required this.userName,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${AppString.hello}, $userName 👋',
              style: AppTextStyles.h4(),
            ),
            AppGap.g4,
            Text(
              getGreetingMessage(),
              style: AppTextStyles.caption(color: AppColor.textPrimary),
            ),
          ],
        ),

        CircleAvatar(
          radius:28,
          child: userName.isNotEmpty
              ? Text(
            userName[0],
            style: AppTextStyles.h3(
              color: AppColor.primary,
            ),
          )
              : const SizedBox()
        )
      ],
    );
  }

  String getGreetingMessage() {
    final hour = DateTime.now().hour;
    if (hour < 12) return AppString.goodMorning;
    if (hour < 17) return AppString.goodAfternoon;
    if (hour < 21) return AppString.goodEvening;
    return AppString.goodNight;
  }
}
