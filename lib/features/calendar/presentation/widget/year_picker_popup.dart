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
        final years = List.generate(7, (i) => currentYear - 3 + i);

        return PopupMenuButton<int>(
          onSelected: (year) {
            context.read<CalendarCubit>().selectYear(year);
          },
          itemBuilder: (context) {
            return years.map((y) {
              final isSelected = y == currentYear;

              return PopupMenuItem<int>(
                value: y,
                child: Text(
                  '$y',
                  style: TextStyle(
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    color: isSelected ? AppColor.secondary : AppColor.textPrimary,
                  ),
                ),
              );
            }).toList();
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.menu,size: 28,color: AppColor.background,),
              AppGap.g32,

              Text(
                  '$currentYear',
                  style: AppTextStyles.h4(color: AppColor.background)
              ),
            ],
          ),
        );
      },
    );
  }
}