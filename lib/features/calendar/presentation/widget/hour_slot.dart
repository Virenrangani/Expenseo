import 'package:expenseo/core/constant/padding/app_padding.dart';
import 'package:expenseo/features/calendar/presentation/widget/calendar_expense_slot.dart';
import 'package:flutter/material.dart';
import '../../../../core/constant/border_radius/app_border_radius.dart';
import '../../../../core/constant/colour/app_color.dart';
import '../../../../core/constant/text_style/app_text_style.dart';
import '../../../expense/domain/entity/expense.dart';

class HourSlot extends StatelessWidget {
  final String hourLabel;
  final List<Expense> expenses;

  const HourSlot({
    super.key,
    required this.hourLabel,
    required this.expenses,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width:50,
          child: Text(
            hourLabel,
            style: AppTextStyles.descriptionSmall(),
          ),
        ),

        Expanded(
          child: expenses.isEmpty
              ? _calendarEmptySlot()
              : CalendarExpenseSlot(hourLabel: hourLabel, expenses: expenses),
        ),
      ],
    );
  }

  Widget _calendarEmptySlot() {
    return Container(
      margin: AppPadding.edgeAll12,
      height: 36,
      decoration: BoxDecoration(
        color: AppColor.textLight,
        borderRadius: AppBorderRadius.cir8,
        border: Border.all(color: Colors.grey.shade200),
      ),
    );
  }
}