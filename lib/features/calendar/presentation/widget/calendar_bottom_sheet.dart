import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/constant/border_radius/app_border_radius.dart';
import '../../../../core/constant/colour/app_color.dart';
import '../../../../core/constant/gap/app_gap.dart';
import '../../../../core/constant/padding/app_padding.dart';
import '../../../../core/constant/text_style/app_text_style.dart';
import '../../../../core/widget/hour_label/hour_label.dart';
import '../../../expense/domain/entity/expense.dart';
import '../../../expense/presentation/cubit/expense_cubit.dart';
import '../../../expense/presentation/cubit/expense_state.dart';
import 'hour_slot.dart';

class CalendarBottomSheet extends StatelessWidget {
  const CalendarBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.background,
        borderRadius: AppBorderRadius.cir28,
      ),
      child: Column(
        children: [
          AppGap.g16,
          Expanded(
            child: BlocBuilder<ExpenseCubit, ExpenseState>(
              builder: (context, state) {
                if (state is ExpenseLoading) {
                  return ListView.builder(
                    padding: AppPadding.edgeSymmetricHori16,
                    itemCount: 24,
                    itemBuilder: (context, hour) {
                      return Skeletonizer(
                        child: HourSlot(
                          hourLabel: hourLabel(hour),
                          expenses: const [],
                        ),
                      );
                    },
                  );
                }

                if (state is ExpenseError) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        state.message,
                        style: AppTextStyles.bodyMedium(color: AppColor.error),
                      ),
                    ),
                  );
                }

                final expenses = state is ExpenseLoaded
                    ? (state.expenses ?? [])
                    : <Expense>[];

                final grouped = _groupByHour(expenses);

                return ListView.builder(
                  padding: AppPadding.edgeSymmetricHori16,
                  itemCount: 24,
                  itemBuilder: (context, hour) {
                    final label = hourLabel(hour);
                    final slotExpenses = grouped[hour] ?? [];

                    return HourSlot(
                      key: ValueKey('$label-${slotExpenses.length}'),
                      hourLabel: label,
                      expenses: slotExpenses,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Map<int, List<Expense>> _groupByHour(List<Expense> expenses) {
    final Map<int, List<Expense>> map = {
      for (int h = 0; h < 24; h++) h: <Expense>[],
    };

    for (final e in expenses) {
      final localDateTime = e.createdAt;
      final h = localDateTime.hour;

      if (map.containsKey(h)) {
        map[h]!.add(e);
      }
    }

    return map;
  }
}
