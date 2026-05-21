import 'package:expenseo/core/constant/gap/app_gap.dart';
import 'package:flutter/material.dart';

import '../../../../core/enums/expense_filter_enums.dart';
import 'filter_tab_section.dart';

class ScrollTabBar extends StatefulWidget {

  final void Function(
      DateFilter dateFilter,
      TypeFilter typeFilter,
      CategoryFilter categoryFilter,
      PaymentType paymentFilter
      ) onFilterChanged;

  const ScrollTabBar({
    super.key,
    required this.onFilterChanged,
  });

  @override
  State<ScrollTabBar> createState() => _ScrollTabBarState();
}

class _ScrollTabBarState extends State<ScrollTabBar> {

  DateFilter selectedDateFilter = DateFilter.all;
  TypeFilter selectedTypeFilter = TypeFilter.all;
  CategoryFilter selectedCategoryFilter = CategoryFilter.all;
  PaymentType selectPaymentFilter = PaymentType.all;

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
          selectedValue:selectedDateFilter,
          onSelected: (value) {
            setState(() {
              selectedDateFilter = value;
            });
            widget.onFilterChanged(
              selectedDateFilter,
              selectedTypeFilter,
              selectedCategoryFilter,
              selectPaymentFilter
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
          selectedValue: selectedTypeFilter,
          onSelected: (value) {
            setState(() {
              selectedTypeFilter = value;
            });

            widget.onFilterChanged(
              selectedDateFilter,
              selectedTypeFilter,
              selectedCategoryFilter,
              selectPaymentFilter
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
            selectedValue: selectedCategoryFilter,
            onSelected: (value) {
              setState(() {
                selectedCategoryFilter = value;
              });

              widget.onFilterChanged(
                selectedDateFilter,
                selectedTypeFilter,
                selectedCategoryFilter,
                selectPaymentFilter
              );
            },
        ),

        AppGap.g12,
        FilterTabSection(
            tabs: const [
              'All',
              'Upi',
              'Cash',
              'Card',
              'NetBanking'
            ],
            values: PaymentType.values,
            selectedValue: selectPaymentFilter,
            onSelected: (value) {
              setState(() {
                selectPaymentFilter = value;
              });

              widget.onFilterChanged(
                selectedDateFilter,
                selectedTypeFilter,
                selectedCategoryFilter,
                selectPaymentFilter
              );
            },
        )
      ],
    );
  }
}