import 'package:expenseo/core/constant/colour/app_color.dart';
import 'package:expenseo/core/constant/gap/app_gap.dart';
import 'package:expenseo/core/constant/padding/app_padding.dart';
import 'package:expenseo/core/constant/text_style/app_text_style.dart';
import 'package:expenseo/core/widget/text_field/app_text_field.dart';
import 'package:flutter/material.dart';

class AddStockPage extends StatefulWidget {
  const AddStockPage({super.key});

  @override
  State<AddStockPage> createState() => _AddStockPageState();
}

class _AddStockPageState extends State<AddStockPage> {
  final TextEditingController dateController = TextEditingController();
  final TextEditingController buyStockController = TextEditingController();
  final TextEditingController stockNameController = TextEditingController();
  final TextEditingController stockSymbolController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppPadding.edgeAll12,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          label('Stock'),
          AppGap.g4,
          AppFormField(
            hintText: 'Stock name',
            controller: stockNameController,
            prefixIcon: const Icon(
              Icons.show_chart,
              color: AppColor.textSecondary,
            ),
          ),

          AppGap.g12,

          label('Stock Symbol'),
          AppGap.g4,
          AppFormField(
            controller: stockSymbolController,
            hintText: 'Stock Symbol',
            prefixIcon: const Icon(Icons.image, color: AppColor.textSecondary),
          ),

          AppGap.g12,

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  children: [
                    label('Buy Price'),
                    AppGap.g4,
                    AppFormField(
                      controller: buyStockController,
                      hintText: 'Buy Price',
                      prefixIcon: const Icon(
                        Icons.monetization_on_outlined,
                        color: AppColor.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              AppGap.g8,
              Expanded(
                child: Column(
                  children: [
                    label('Buy Date'),
                    AppGap.g4,
                    AppFormField(
                      hintText: 'Buy Date',
                      controller: dateController,
                      suffix: IconButton(
                        onPressed: () async {
                          final DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(3000),
                          );

                          if (pickedDate != null) {
                            dateController.text =
                                '${pickedDate.day}/${pickedDate.month}/${pickedDate.year}';
                          }
                        },
                        icon: const Icon(Icons.date_range),
                      ),
                    ),
                  ],
                ),
              ),
            ],
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
