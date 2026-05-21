import 'dart:ui';

import 'package:expenseo/core/constant/border_radius/app_border_radius.dart';
import 'package:expenseo/core/constant/gap/app_gap.dart';
import 'package:expenseo/core/constant/padding/app_padding.dart';
import 'package:expenseo/core/constant/string/app_string.dart';
import 'package:expenseo/features/expense/presentation/widget/scroll_tab_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constant/colour/app_color.dart';
import '../../../../core/constant/text_style/app_text_style.dart';
import '../cubit/expense_cubit.dart';

class FilterDialog extends StatelessWidget {
  const FilterDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<ExpenseCubit>();
    return Scaffold(
          backgroundColor: Colors.transparent,
          body: Align(
            alignment: Alignment.bottomCenter,
            child: ClipRRect(
              borderRadius: AppBorderRadius.verTop24,

              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX:30, sigmaY: 30),

                child: Container(
                  height: MediaQuery.of(context).size.height * 0.50,

                  padding: AppPadding.edgeAll20,

                  decoration: BoxDecoration(
                    color: AppColor.background,

                    borderRadius: AppBorderRadius.verTop24
                  ),

                  child: Column(
                    children: [

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(AppString.filter, style: AppTextStyles.h5()),
                          Row(
                            children: [
                              TextButton(
                                onPressed: () {
                                  context.read<ExpenseCubit>().clearFilter();
                                },
                                child: Text(AppString.clearAll,style: AppTextStyles.captionBold(),),
                              ),
                              IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: const Icon(Icons.close , color: AppColor.primary,),
                              ),
                            ],
                          )
                        ],
                      ),

                      AppGap.g16,

                      Expanded(
                        child: SingleChildScrollView(
                          child: ScrollTabBar(
                            onFilterChanged:
                                (
                                  dateFilter,
                                  typeFilter,
                                  categoryFilter,
                                  paymentFilter,
                                ) {
                                  context.read<ExpenseCubit>().applyFilters(
                                    dateFilter: dateFilter,
                                    typeFilter: typeFilter,
                                    categoryFilter: categoryFilter,
                                    paymentFilter: paymentFilter,
                                  );
                                },
                            selectedDateFilter: cubit.selectedDateFilter,
                            selectedTypeFilter: cubit.selectedTypeFilter,
                            selectedCategoryFilter: cubit.selectedCategoryFilter,
                            selectedPaymentFilter: cubit.selectedPaymentFilter,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
  }
}
