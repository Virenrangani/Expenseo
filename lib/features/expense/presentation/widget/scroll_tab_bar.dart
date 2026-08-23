import 'package:expenseo/core/constant/gap/app_gap.dart';
import 'package:expenseo/core/extension/localization_extension.dart';
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
    PaymentType paymentFilter,
  )
  onFilterChanged;

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
          tabs: [
            context.l10n.all,
            context.l10n.today,
            context.l10n.week,
            context.l10n.month,
          ],

          values: DateFilter.values,
          selectedValue: widget.selectedDateFilter,
          onSelected: (value) {
            widget.onFilterChanged(
              value,
              widget.selectedTypeFilter,
              widget.selectedCategoryFilter,
              widget.selectedPaymentFilter,
            );
          },
        ),

        AppGap.g12,

        FilterTabSection<TypeFilter>(
          tabs: [context.l10n.all, context.l10n.income, context.l10n.expense],

          values: TypeFilter.values,
          selectedValue: widget.selectedTypeFilter,
          onSelected: (value) {
            widget.onFilterChanged(
              widget.selectedDateFilter,
              value,
              widget.selectedCategoryFilter,
              widget.selectedPaymentFilter,
            );
          },
        ),

        AppGap.g12,
        FilterTabSection(
          tabs: [
            context.l10n.all,
            context.l10n.food,
            context.l10n.shopping,
            context.l10n.transport,
            context.l10n.health,
            context.l10n.entertainment,
            context.l10n.salary,
            context.l10n.rent,
            context.l10n.other,
          ],
          values: CategoryFilter.values,
          selectedValue: widget.selectedCategoryFilter,
          onSelected: (value) {
            widget.onFilterChanged(
              widget.selectedDateFilter,
              widget.selectedTypeFilter,
              value,
              widget.selectedPaymentFilter,
            );
          },
        ),

        AppGap.g12,
        FilterTabSection(
          tabs: [
            context.l10n.all,
            context.l10n.cash,
            context.l10n.upi,
            context.l10n.card,
            context.l10n.netBanking,
          ],
          values: PaymentType.values,
          selectedValue: widget.selectedPaymentFilter,
          onSelected: (value) {
            widget.onFilterChanged(
              widget.selectedDateFilter,
              widget.selectedTypeFilter,
              widget.selectedCategoryFilter,
              value,
            );
          },
        ),
      ],
    );
  }
}
