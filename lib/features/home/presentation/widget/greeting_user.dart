import 'package:flutter/material.dart';

import '../../../../core/constant/colour/app_color.dart';
import '../../../../core/constant/gap/app_gap.dart';
import '../../../../core/constant/text_style/app_text_style.dart';
import '../../../../core/extension/localization_extension.dart';

class GreetingUser extends StatelessWidget {
  final String userName;

  const GreetingUser({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    final last = userName.substring(1);
    final firstChar = userName[0].toUpperCase();
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: AppColor.primary.withAlpha(35),
          radius: 28,
          child: userName.isNotEmpty
              ? Text(
                  firstChar,
                  style: AppTextStyles.h2(color: AppColor.primary),
                )
              : const SizedBox(),
        ),
        AppGap.g16,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(getGreetingMessage(context), style: AppTextStyles.h3()),
            Text('$firstChar$last ', style: AppTextStyles.h4()),
          ],
        ),
      ],
    );
  }

  String getGreetingMessage(BuildContext context) {
    final hour = DateTime.now().hour;
    if (hour < 12) return context.l10n.goodMorning;
    if (hour < 17) return context.l10n.goodAfternoon;
    if (hour < 21) return context.l10n.goodEvening;
    return context.l10n.goodNight;
  }
}
