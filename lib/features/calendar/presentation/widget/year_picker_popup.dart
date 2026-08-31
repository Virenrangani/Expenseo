import 'package:expenseo/core/constant/border_radius/app_border_radius.dart';
import 'package:expenseo/core/constant/colour/app_color.dart';
import 'package:expenseo/core/constant/gap/app_gap.dart';
import 'package:expenseo/core/constant/text_style/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/calendar_cubit.dart';
import '../cubit/calendar_state.dart';

class YearPickerPopup extends StatelessWidget {
  const YearPickerPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalendarCubit, CalendarState>(
      builder: (context, state) {
        if (state is! CalendarLoaded) {
          return const SizedBox();
        }

        final currentYear = state.year;

        return GestureDetector(
          onTap: () {
            final first = DateTime(currentYear - 50);
            final last = DateTime(currentYear + 10);

            showModalBottomSheet<void>(
              context: context,
              isScrollControlled: true,
              backgroundColor: AppColor.background,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              builder: (ctx) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height * 0.6,
                  child: Column(
                    children: [
                      const SizedBox(height: 12),
                      Container(
                        width: 36,
                        height: 4,
                        decoration: BoxDecoration(
                          color: AppColor.textSecondary,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Select Year', style: AppTextStyles.h4()),
                            IconButton(
                              onPressed: () => Navigator.of(ctx).pop(),
                              icon: const Icon(Icons.close),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Expanded(
                        child: YearPicker(
                          firstDate: first,
                          lastDate: last,
                          selectedDate: DateTime(currentYear),
                          onChanged: (date) {
                            context.read<CalendarCubit>().selectYear(date.year);
                            Navigator.of(ctx).pop();
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: AppColor.background.withAlpha(20),
              border: Border.all(color: AppColor.background.withAlpha(35)),
              borderRadius: AppBorderRadius.cir20,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.calendar_month_rounded,
                  size: 18,
                  color: AppColor.background,
                ),
                AppGap.g8,
                Text(
                  '$currentYear',
                  style: AppTextStyles.h5(color: AppColor.background),
                ),
                AppGap.g4,
                const Icon(
                  Icons.keyboard_arrow_down_rounded,
                  size: 18,
                  color: AppColor.background,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
