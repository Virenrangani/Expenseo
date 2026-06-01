import 'package:expenseo/core/constant/colour/app_color.dart';
import 'package:expenseo/core/constant/gap/app_gap.dart';
import 'package:expenseo/core/constant/padding/app_padding.dart';
import 'package:expenseo/core/constant/text_style/app_text_style.dart';
import 'package:expenseo/core/widget/text_field/app_text_field.dart';
import 'package:flutter/material.dart';

class AddStockPage extends StatelessWidget {
  const AddStockPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppPadding.edgeAll12,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          label('Stock'),
          AppGap.g4,
          const AppFormField(
            hintText: 'Stack name',
            prefixIcon: Icon(Icons.show_chart, color: AppColor.textSecondary),
          ),
        ],
      ),
    );
  }

  Widget label(String name) {
    return Text(
      name,
      style: AppTextStyles.captionBold(color: AppColor.textSecondary),
    );
  }
}
