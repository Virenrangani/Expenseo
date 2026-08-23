import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constant/border_radius/app_border_radius.dart';
import '../../../../core/constant/colour/app_color.dart';
import '../../../../core/constant/gap/app_gap.dart';
import '../../../../core/constant/padding/app_padding.dart';
import '../../../../core/constant/text_style/app_text_style.dart';
import '../../../../core/extension/localization_extension.dart';
import '../cubit/expense_cubit.dart';
import 'filter_dailog.dart';

class FilterButton extends StatelessWidget {
  const FilterButton({super.key});

  @override
  Widget build(BuildContext context) {
    final expenseCubit = context.read<ExpenseCubit>();
    return GestureDetector(
      onTap: () {
        showGeneralDialog(
          context: context,
          barrierDismissible: true,
          barrierLabel: context.l10n.filter,
          barrierColor: Colors.black.withAlpha(150),
          transitionDuration: const Duration(milliseconds: 400),

          pageBuilder: (context, animation, secondaryAnimation) {
            return BlocProvider.value(
              value: expenseCubit,
              child: const FilterDialog(),
            );
          },

          transitionBuilder: (context, animation, secondaryAnimation, child) {
            final slideAnimation =
                Tween<Offset>(
                  begin: const Offset(0, 1),
                  end: Offset.zero,
                ).animate(
                  CurvedAnimation(
                    parent: animation,
                    curve: Curves.easeOutCubic,
                  ),
                );

            final fadeAnimation = Tween<double>(
              begin: 0,
              end: 1,
            ).animate(animation);

            return FadeTransition(
              opacity: fadeAnimation,
              child: SlideTransition(position: slideAnimation, child: child),
            );
          },
        );
      },
      child: Container(
        padding: AppPadding.edgeAll8,
        decoration: BoxDecoration(
          color: AppColor.primary.withAlpha(30),
          borderRadius: AppBorderRadius.cir12,
          border: Border.all(
            width: 1.5,
            color: AppColor.primary.withAlpha(150),
          ),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.filter_list_sharp,
              size: 22,
              color: AppColor.primary,
            ),
            AppGap.g4,
            Text(context.l10n.filter, style: AppTextStyles.captionBold()),
          ],
        ),
      ),
    );
  }
}
