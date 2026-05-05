import 'package:expenseo/core/constant/colour/app_color.dart';
import 'package:expenseo/core/constant/padding/app_padding.dart';
import 'package:expenseo/core/constant/string/app_string.dart';
import 'package:expenseo/features/split/presentation/cubit/split_cubit.dart';
import 'package:expenseo/features/split/presentation/page/split_group_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../../core/constant/text_style/app_text_style.dart';

class SplitExpense extends StatelessWidget {
  const SplitExpense({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SplitCubit>(
      create: (_) => GetIt.I<SplitCubit>(),
      child: Scaffold(
        backgroundColor: AppColor.primaryLight,
        body: Builder(
          builder: (context) {
            return SafeArea(
                child: Padding(
                  padding: AppPadding.edgeAll12,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(AppString.splitBill,
                            style: AppTextStyles.h4(color: AppColor.secondary),),
                          IconButton(
                              onPressed: () {
                                final splitCubit = context.read<SplitCubit>();
                                showModalBottomSheet<void>(
                                  context: context,
                                  isScrollControlled: true,
                                  backgroundColor: Colors.transparent,
                                  builder: (_) =>
                                      BlocProvider.value(
                                        value: splitCubit,
                                        child: const SplitGroupBottomSheet(),
                                      ),
                                );
                              },
                              icon: const Icon(Icons.add_circle, size: 32,
                                color: AppColor.secondary,)
                          ),
                        ],
                      ),
                    ],
                  ),
                )
            );
          }
        ),
      ),
    );
  }
}
