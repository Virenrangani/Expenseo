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
    final last=userName.substring(1);
    final firstChar =userName[0].toUpperCase();
    return Row(
      children: [
        CircleAvatar(
            backgroundColor: AppColor.primary.withAlpha(35),
            radius:28,
            child: userName.isNotEmpty
                ? Text(
              firstChar,
              style: AppTextStyles.h2(
                color: AppColor.primary,
              ),
            )
                : const SizedBox()
        ),
        AppGap.g16,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              getGreetingMessage(),
              style: AppTextStyles.h3(),
            ),
            AppGap.g4,
            Text(
              '$firstChar$last ',style: AppTextStyles.h4(),
            ),
          ],
        ),
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
