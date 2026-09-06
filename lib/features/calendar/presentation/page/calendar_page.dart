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

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  late final ExpenseCubit _expenseCubit;

  @override
  void initState() {
    super.initState();
    _expenseCubit = GetIt.I<ExpenseCubit>();

    final calState = context.read<CalendarCubit>().state;
    if (calState is CalendarLoaded) {
      _expenseCubit.getExpensesByDate(
        DateTime(calState.year, calState.month + 1, calState.day),
      );
    } else {
      final now = DateTime.now();
      _expenseCubit.getExpensesByDate(now);
    }
  }

  @override
  void dispose() {
    // Do not close shared ExpenseCubit (it's provided as a singleton by GetIt)
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _expenseCubit,
      child: Scaffold(
        backgroundColor: const Color(0xFFF3F6FF),
        body: SafeArea(
          child: BlocListener<CalendarCubit, CalendarState>(
            listenWhen: (prev, curr) {
              if (prev is CalendarLoaded && curr is CalendarLoaded) {
                return prev.day != curr.day ||
                    prev.month != curr.month ||
                    prev.year != curr.year;
              }
              return curr is CalendarLoaded;
            },
            listener: (context, state) {
              if (state is CalendarLoaded) {
                _expenseCubit.getExpensesByDate(
                  DateTime(state.year, state.month + 1, state.day),
                );
              }
            },
            child: Padding(
              padding: AppPadding.edgeSymmetricHori16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppGap.g12,
                  _buildHeader(context),
                  AppGap.g20,
                  _buildCalendarControls(),
                  AppGap.g20,
                  const Expanded(child: CalendarBottomSheet()),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Calendar', style: AppTextStyles.h2()),
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
              showModalBottomSheet<void>(
                context: context,
                isScrollControlled: true,
                backgroundColor: AppColor.background,
                builder: (_) => BlocProvider.value(
                  value: _expenseCubit,
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
    );
  }

  Widget _buildCalendarControls() {
    return Container(
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
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              color: AppColor.background.withAlpha(16),
              borderRadius: BorderRadius.circular(18),
            ),
            child: const DayScrollBar(),
          ),
        ],
      ),
    );
  }
}
