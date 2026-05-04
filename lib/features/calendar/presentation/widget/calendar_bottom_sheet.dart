import 'package:expenseo/core/constant/string/app_string.dart';
import 'package:expenseo/features/expense/presentation/widget/fake_expense.dart';
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

          Container(
            width:  36,
            height: 4,
            decoration: BoxDecoration(
              color:AppColor.textSecondary,
              borderRadius: AppBorderRadius.cir4,
            ),
          ),
          AppGap.g16,

          Expanded(
            child: BlocBuilder<ExpenseCubit, ExpenseState>(
              builder: (context, state) {

                if (state is ExpenseLoading) {
                  return Skeletonizer(
                      child: HourSlot(
                        hourLabel:AppString.hourLabel,
                        expenses: List.generate(8, (index) => FakeExpense.fake(),),
                      )
                  );
                }

                if (state is ExpenseError) {
                  return Center(child: Text(state.message));
                }

                if (state is ExpenseLoaded) {
                  final expenses = state.expenses ?? [];

                  if (expenses.isEmpty) {
                    return _buildEmptyState();
                  }

                  final grouped = _groupByHour(expenses);

                  return ListView(
                    padding: AppPadding.edgeSymmetricHori16,
                    children: grouped.entries.map((entry) {
                      return HourSlot(
                        hourLabel: entry.key,
                        expenses:  entry.value,
                      );
                    }).toList(),
                  );
                }

                return _buildEmptyState();
              },
            ),
          ),
        ],
      ),
    );
  }

  Map<String, List<Expense>> _groupByHour(List<Expense> expenses) {
    final Map<String, List<Expense>> map = {};

    for (int h = 0; h < 24; h++) {
      final label = hourLabel(h);
      map[label] = [];
    }

    for (final e in expenses) {
      final label = hourLabel(e.createdAt.hour);
      map[label]!.add(e);
    }

    return map;
  }


  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.receipt_long_outlined,
              size: 48, color: AppColor.divider),
          AppGap.g12,
          Text(
            AppString.noExpenseOfThisDay,
            style: AppTextStyles.caption(),
          ),
        ],
      ),
    );
  }
}


