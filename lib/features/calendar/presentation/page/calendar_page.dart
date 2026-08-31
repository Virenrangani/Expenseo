import 'package:expenseo/core/constant/gap/app_gap.dart';
import 'package:expenseo/core/constant/padding/app_padding.dart';
import 'package:expenseo/core/constant/text_style/app_text_style.dart';
import 'package:expenseo/features/calendar/presentation/cubit/calendar_cubit.dart';
import 'package:expenseo/features/calendar/presentation/cubit/calendar_state.dart';
import 'package:expenseo/features/calendar/presentation/widget/day_scroll_bar.dart';
import 'package:expenseo/features/calendar/presentation/widget/month_scroll_bar.dart';
import 'package:expenseo/features/calendar/presentation/widget/year_picker_popup.dart';
import 'package:expenseo/features/expense/presentation/cubit/expense_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../../core/constant/colour/app_color.dart';
import '../../../expense/presentation/page/add_expense_sheet.dart';
import '../widget/calendar_bottom_sheet.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: context.read<CalendarCubit>()),
        BlocProvider(create: (_) => GetIt.I<ExpenseCubit>()),
      ],
      child: Builder(
        builder: (context) {
          return Scaffold(
            backgroundColor: const Color(0xFFF3F6FF),
            body: SafeArea(
              child: BlocListener<CalendarCubit, CalendarState>(
                listenWhen: (prev, curr) {
                  if (prev is CalendarLoaded && curr is CalendarLoaded) {
                    return prev.day != curr.day;
                  }
                  return false;
                },
                listener: (context, state) {
                  if (state is CalendarLoaded) {
                    final selectedDate = DateTime(
                      state.year,
                      state.month + 1,
                      state.day,
                    );

                    final expenseCubit = context.read<ExpenseCubit>()
                      ..getExpensesByDate(selectedDate);

                    showModalBottomSheet<void>(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: AppColor.background,
                      builder: (_) => BlocProvider.value(
                        value: expenseCubit,
                        child: const FractionallySizedBox(
                          heightFactor: 0.70,
                          child: CalendarBottomSheet(),
                        ),
                      ),
                    );
                  }
                },
                child: Padding(
                  padding: AppPadding.edgeSymmetricHori16,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppGap.g12,
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Calendar',
                                  style: AppTextStyles.h2(),
                                ),
                                AppGap.g4,
                                Text(
                                  'Track your spending with clarity',
                                  style: AppTextStyles.bodyMedium(),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [AppColor.primary, AppColor.tertiary],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(18),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColor.primary.withAlpha(80),
                                  blurRadius: 14,
                                  offset: const Offset(0, 8),
                                ),
                              ],
                            ),
                            child: IconButton(
                              onPressed: () {
                                final expenseCubit = context.read<ExpenseCubit>();
                                showModalBottomSheet<void>(
                                  context: context,
                                  isScrollControlled: true,
                                  backgroundColor: AppColor.background,
                                  builder: (_) => BlocProvider.value(
                                    value: expenseCubit,
                                    child: const AddExpenseSheet(),
                                  ),
                                );
                              },
                              icon: const Icon(
                                Icons.add_rounded,
                                size: 26,
                                color: AppColor.background,
                              ),
                            ),
                          ),
                        ],
                      ),
                      AppGap.g20,
                      Container(
                        padding: const EdgeInsets.only(top: 16, bottom: 12),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF2A5CF6), Color(0xFF5C6CFF)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF2A5CF6).withAlpha(80),
                              blurRadius: 20,
                              offset: const Offset(0, 12),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Month',
                                    style: AppTextStyles.caption(
                                      color: AppColor.background.withAlpha(180),
                                    ),
                                  ),
                                  const YearPickerPopup(),
                                ],
                              ),
                            ),
                            AppGap.g12,
                            const MonthScrollBar(),
                            AppGap.g8,
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 16),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: AppColor.background.withAlpha(16),
                                borderRadius: BorderRadius.circular(18),
                              ),
                              child: const DayScrollBar(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
