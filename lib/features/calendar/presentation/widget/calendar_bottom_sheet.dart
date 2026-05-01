import 'package:expenseo/core/constant/colour/app_color.dart';
import 'package:expenseo/core/constant/gap/app_gap.dart';
import 'package:expenseo/core/constant/padding/app_padding.dart';
import 'package:expenseo/features/calendar/presentation/widget/time_slot.dart';
import 'package:flutter/material.dart';

import '../../../../core/constant/border_radius/app_border_radius.dart';

class CalendarBottomSheet extends StatelessWidget {
  const CalendarBottomSheet({super.key});

  static const _slots = [
    ('01 AM', true),
    ('02 AM', false),
    ('03 AM', false),
    ('04 AM', true),
    ('05 AM', false),
    ('06 AM', false),
    ('08 AM', true),
    ('09 AM', false),
    ('10 AM', true),
    ('11 AM', false),
    ('12 AM', false),

    ('01 PM', true),
    ('02 PM', false),
    ('03 PM', false),
    ('04 PM', true),
    ('05 PM', false),
    ('06 PM', false),
    ('08 PM', true),
    ('09 PM', false),
    ('10 PM', true),
    ('11 PM', false),
    ('12 PM', false),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:  BoxDecoration(
        color: AppColor.background,
        borderRadius: AppBorderRadius.cir28
      ),
      child: Column(
        children: [
          AppGap.g16,
          Container(
            width: 36,
            height: 4,
            decoration: BoxDecoration(
              color: AppColor.textSecondary,
              borderRadius: AppBorderRadius.cir4
            ),
          ),
          AppGap.g16,
          Expanded(
            child: ListView(
              padding:AppPadding.edgeSymmetricHori16,
              children: _slots
                  .map((s) => TimeSlot(label: s.$1, hasBlock: s.$2))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}

