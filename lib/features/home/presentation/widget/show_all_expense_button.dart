import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constant/border_radius/app_border_radius.dart';
import '../../../../core/constant/colour/app_color.dart';
import '../../../../core/constant/gap/app_gap.dart';
import '../../../../core/constant/padding/app_padding.dart';
import '../../../../core/constant/text_style/app_text_style.dart';
import '../../../../core/extension/localization_extension.dart';
import '../../../expense/presentation/cubit/expense_cubit.dart';
import '../../../expense/presentation/page/user_expense_page.dart';

class ShowAllExpenseButton extends StatelessWidget {
  const ShowAllExpenseButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: AppBorderRadius.cir20,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute<void>(
            builder: (_) => BlocProvider.value(
              value: context.read<ExpenseCubit>(),
              child: const UserExpensePage(),
            ),
          ),
        );
      },

      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),

        padding: AppPadding.edgeSymmetricHori8,

        decoration: BoxDecoration(
          color: AppColor.background,
          borderRadius: AppBorderRadius.cir20,
          boxShadow: [
            BoxShadow(
              color: AppColor.textPrimary.withAlpha(20),
              offset: const Offset(0, 2),
            ),
          ],
        ),

        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              context.l10n.showAll,
              style: AppTextStyles.captionMedium(color: AppColor.textPrimary),
            ),

            AppGap.g4,

            const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 12,
              color: AppColor.textPrimary,
            ),
          ],
        ),
      ),
    );
  }
}
