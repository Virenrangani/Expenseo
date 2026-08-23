import 'package:expenseo/core/extension/localization_extension.dart';
import 'package:flutter/cupertino.dart';

import '../../constant/border_radius/app_border_radius.dart';
import '../../constant/colour/app_color.dart';
import '../../constant/gap/app_gap.dart';
import '../../constant/padding/app_padding.dart';
import '../../constant/text_style/app_text_style.dart';
import '../../validation/amount_validation/amount_validation.dart';
import '../text_field/app_text_field.dart';

class AmountBox extends StatefulWidget {
  final TextEditingController controller;
  const AmountBox({super.key, required this.controller});

  @override
  State<AmountBox> createState() => _AmountBoxState();
}

class _AmountBoxState extends State<AmountBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: AppPadding.edgeAll12,
      decoration: BoxDecoration(
        color: AppColor.primaryLight,
        borderRadius: AppBorderRadius.cir16,
      ),
      child: Column(
        children: [
          Text(
            context.l10n.addAmount,
            style: AppTextStyles.captionMedium(color: AppColor.background),
          ),
          AppGap.g8,

          AppFormField(
            controller: widget.controller,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),

            textAlign: TextAlign.center,
            style: AppTextStyles.h3(color: AppColor.primary),

            hintText: '0',
            prefixText: '₹ ',
            prefixStyle: AppTextStyles.h2(color: AppColor.primary),

            contentPadding: EdgeInsets.zero,
            validator: (val) => validateAmount(val!, context),
          ),
        ],
      ),
    );
  }
}
