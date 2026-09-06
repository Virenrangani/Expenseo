import 'package:flutter/material.dart';

import '../../../../core/constant/border_radius/app_border_radius.dart';
import '../../../../core/constant/colour/app_color.dart';
import '../../../../core/constant/text_style/app_text_style.dart';
import '../../../expense/domain/entity/expense.dart';
import 'calendar_expense_slot.dart';

class HourSlot extends StatelessWidget {
  final String hourLabel;
  final List<Expense> expenses;

  const HourSlot({super.key, required this.hourLabel, required this.expenses});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 2),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 54,
                child: Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Text(
                    hourLabel,
                    style: AppTextStyles.descriptionSmall(),
                  ),
                ),
              ),
              Expanded(
                child: expenses.isEmpty
                    ? _buildEmptySlot()
                    : CalendarExpenseSlot(
                        hourLabel: hourLabel,
                        expenses: expenses,
                      ),
              ),
            ],
          ),
        ),
        Divider(
          height: 12,
          thickness: 1,
          indent: 54,
          endIndent: 8,
          color: Colors.grey.shade200,
        ),
      ],
    );
  }

  Widget _buildEmptySlot() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      height: 36,
      decoration: BoxDecoration(
        color: AppColor.textLight.withAlpha(50),
        borderRadius: AppBorderRadius.cir8,
        border: Border.all(color: Colors.grey.shade200),
      ),
    );
  }
}
