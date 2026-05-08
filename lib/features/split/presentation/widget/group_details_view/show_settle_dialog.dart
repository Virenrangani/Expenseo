import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constant/border_radius/app_border_radius.dart';
import '../../../../../core/constant/colour/app_color.dart';
import '../../../../../core/constant/gap/app_gap.dart';
import '../../../../../core/constant/padding/app_padding.dart';
import '../../../../../core/constant/string/app_string.dart';
import '../../../../../core/constant/text_style/app_text_style.dart';
import '../../cubit/split_cubit.dart';

void showSettleDialog({
  required BuildContext context,
  required String groupId,
  required String uid,
  required String name,
  required double amount,
}) {

  final isOwedToMe = amount > 0;

  showDialog<void>(
    context: context,

    builder: (_) {

      return Dialog(
        backgroundColor: Colors.transparent,

        child: Container(
          padding: AppPadding.edgeAll20,

          decoration: BoxDecoration(
            color: AppColor.background,
            borderRadius: AppBorderRadius.cir20,
          ),

          child: Column(
            mainAxisSize: MainAxisSize.min,

            children: [

              Container(
                width: 70,
                height: 70,

                decoration: BoxDecoration(
                  shape: BoxShape.circle,

                  color: isOwedToMe
                      ? AppColor.success.withAlpha(14)
                      : AppColor.error.withAlpha(14),
                ),

                child: Icon(
                  isOwedToMe
                      ? Icons.arrow_downward_rounded
                      : Icons.arrow_upward_rounded,
                  size: 34,
                  color: isOwedToMe
                      ? AppColor.success
                      : AppColor.error,
                ),
              ),

              AppGap.g20,

              Text(
                AppString.settleUp,

                style: AppTextStyles.h4(),
              ),

              AppGap.g12,

              Text(
                name,
                style: AppTextStyles.bodyLarge().copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),

              AppGap.g8,

              Text(
                '₹${amount.abs().toStringAsFixed(2)}',

                style: AppTextStyles.h3(
                  color: isOwedToMe
                      ? AppColor.success
                      : AppColor.error,
                ),
              ),

              AppGap.g12,

              Text(
                isOwedToMe
                    ? '$name ${AppString.owesYou}'
                    : '${AppString.owe} $name.',
                textAlign: TextAlign.center,
                style: AppTextStyles.bodySmall(),
              ),

              AppGap.g24,

              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },

                      style: OutlinedButton.styleFrom(
                        padding: AppPadding.edgeSymmetricVer12,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                          AppBorderRadius.cir12,
                        ),
                      ),

                      child: Text(
                        AppString.cancel, style: AppTextStyles.captionMedium(),
                      ),
                    ),
                  ),

                  AppGap.g12,

                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        context.read<SplitCubit>().settleUp(
                          groupId: groupId,
                          toUid: uid,
                          toName: name,
                          amount: amount.abs(),
                        );
                      },

                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.primary,
                        padding: AppPadding.edgeSymmetricHori16,

                        shape: RoundedRectangleBorder(
                          borderRadius:
                          AppBorderRadius.cir12,
                        ),
                      ),

                      child: Text(
                        AppString.settled, style:
                      AppTextStyles.captionMedium(color: AppColor.background,),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}