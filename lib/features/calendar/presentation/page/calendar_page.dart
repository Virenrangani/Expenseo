import 'package:expenseo/core/constant/gap/app_gap.dart';
import 'package:expenseo/core/constant/padding/app_padding.dart';
import 'package:expenseo/features/calendar/presentation/cubit/calendar_cubit.dart';
import 'package:expenseo/features/calendar/presentation/widget/day_scroll_bar.dart';
import 'package:expenseo/features/calendar/presentation/widget/month_scroll_bar.dart';
import 'package:expenseo/features/calendar/presentation/widget/year_picker_popup.dart';
import 'package:expenseo/features/expense/presentation/cubit/expense_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../../core/constant/colour/app_color.dart';
import '../../../expense/presentation/page/add_expense_sheet.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => CalendarCubit(),
        ),
        BlocProvider(
          create: (_) => GetIt.I<ExpenseCubit>(),
        ),
      ],
      child: Builder(
        builder: (context) {
          return Scaffold(
            backgroundColor: AppColor.primary,
            body: SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: AppPadding.edgeSymmetricHori24,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const YearPickerPopup(),
                        IconButton(
                            onPressed: () {
                              final expenseCubit=context.read<ExpenseCubit>();
                              showModalBottomSheet<void>(
                                context: context,
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                builder: (_) =>
                                    BlocProvider.value(
                                      value: expenseCubit,
                                      child: const AddExpenseSheet(),
                                    ),
                              );
                            },
                            icon: const Icon(
                              Icons.add, size: 28, color: AppColor.background,)
                        )
                      ],
                    ),
                  ),
                  const MonthScrollBar(),
                  AppGap.g20,
                  const DayScrollBar(),
                ],
              ),
            ),
          );
        }
      ),
    );
  }
}
