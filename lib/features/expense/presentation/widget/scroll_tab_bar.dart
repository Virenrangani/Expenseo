import 'package:expenseo/core/constant/gap/app_gap.dart';
import 'package:flutter/material.dart';

import '../../../../core/enums/expense_filter_enums.dart';
import 'filter_tab_section.dart';

class ScrollTabBar extends StatefulWidget {
  final DateFilter selectedDateFilter;
  final TypeFilter selectedTypeFilter;
  final CategoryFilter selectedCategoryFilter;
  final PaymentType selectedPaymentFilter;
  final void Function(
      DateFilter dateFilter,
      TypeFilter typeFilter,
      CategoryFilter categoryFilter,
      PaymentType paymentFilter
      ) onFilterChanged;

  const ScrollTabBar({
    super.key,
    required this.onFilterChanged,
    required this.selectedDateFilter,
    required this.selectedTypeFilter,
    required this.selectedCategoryFilter,
    required this.selectedPaymentFilter,
  });

  @override
  State<ScrollTabBar> createState() => _ScrollTabBarState();
}

class _ScrollTabBarState extends State<ScrollTabBar> {

  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        FilterTabSection<DateFilter>(
          tabs: const [
            'All',
            'Today',
            'Week',
            'Month',
          ],

          values: DateFilter.values,
          selectedValue:widget.selectedDateFilter,
          onSelected: (value) {
            widget.onFilterChanged(
                value,
                widget.selectedTypeFilter,
                widget.selectedCategoryFilter,
                widget.selectedPaymentFilter
            );
          },
        ),

       AppGap.g12,

        FilterTabSection<TypeFilter>(

          tabs: const [
            'All',
            'Income',
            'Expense',
          ],

          values: TypeFilter.values,
          selectedValue: widget.selectedTypeFilter,
          onSelected: (value) {

            widget.onFilterChanged(
                widget.selectedDateFilter,
                value,
                widget.selectedCategoryFilter,
                widget.selectedPaymentFilter
            );
          },
        ),

        AppGap.g12,
        FilterTabSection(
            tabs: const [
              'All',
              'Food',
             'Shopping',
             'Transport',
             'Health',
              'Entertainment',
              'Salary',
             'Rent',
             'Other',
            ],
            values: CategoryFilter.values,
            selectedValue: widget.selectedCategoryFilter,
            onSelected: (value) {

              widget.onFilterChanged(
                  widget.selectedDateFilter,
                  widget.selectedTypeFilter,
                  value,
                  widget.selectedPaymentFilter
              );
            },
        ),

        AppGap.g12,
        FilterTabSection(
            tabs: const [
              'All',
              'Cash',
              'Upi',
              'Card',
              'NetBanking'
            ],
            values: PaymentType.values,
            selectedValue: widget.selectedPaymentFilter,
            onSelected: (value) {

              widget.onFilterChanged(
                  widget.selectedDateFilter,
                  widget.selectedTypeFilter,
                  widget.selectedCategoryFilter,
                  value
              );
            },
        )
      ],
    );
  }
}