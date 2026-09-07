import 'package:expenseo/core/constant/colour/app_color.dart';
import 'package:expenseo/core/widget/app_app_bar.dart';
import 'package:expenseo/features/split/presentation/cubit/split_cubit.dart';
import 'package:expenseo/features/split/presentation/page/split_group_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../../core/extension/localization_extension.dart';
import '../../../../core/storage/shared_pref/shared_pref_service.dart';
import '../../../../core/widget/login_required_dialog/login_required_dialog.dart';
import '../widget/group/group_list.dart';

class SplitExpense extends StatelessWidget {
  const SplitExpense({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SplitCubit>(
      create: (_) => GetIt.I<SplitCubit>()..getGroups(),
      child: Builder(
        builder: (context) {
          return Scaffold(
            backgroundColor: AppColor.background,
            appBar: AppAppBar(title: context.l10n.splitBill),
            body: const SafeArea(
              child: Column(children: [Expanded(child: GroupsList())]),
            ),

            floatingActionButton: FloatingActionButton(
              backgroundColor: AppColor.primary,
              onPressed: () {
                if (SharedPrefService.isGuest()) {
                  LoginRequiredDialog.show(context, context.l10n.splitBill);
                  return;
                }
                final splitCubit = context.read<SplitCubit>();
                showModalBottomSheet<void>(
                  context: context,
                  isScrollControlled: true,
                  showDragHandle: true,
                  backgroundColor: AppColor.background,
                  builder: (_) => BlocProvider.value(
                    value: splitCubit,
                    child: const SplitGroupBottomSheet(),
                  ),
                );
              },
              child: const Icon(
                Icons.add_circle_outline,
                size: 28,
                color: AppColor.background,
              ),
            ),
          );
        },
      ),
    );
  }
}
