import 'package:expenseo/core/constant/border_radius/app_border_radius.dart';
import 'package:expenseo/core/constant/colour/app_color.dart';
import 'package:expenseo/core/constant/gap/app_gap.dart';
import 'package:expenseo/core/constant/string/app_string.dart';
import 'package:expenseo/core/constant/text_style/app_text_style.dart';
import 'package:expenseo/core/widget/elevated_button/app_elevated_button.dart';
import 'package:expenseo/core/widget/text_field/app_text_field.dart';
import 'package:expenseo/features/investment/main_page/stocks/domain/entity/stock.dart';
import 'package:expenseo/features/investment/main_page/stocks/presentation/cubit/stock_cubit.dart';
import 'package:expenseo/features/investment/main_page/stocks/presentation/widget/stock_sectors_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

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
  final TextEditingController stockQuantityController = TextEditingController();
  final TextEditingController stockSectorController = TextEditingController();

  String selectedExchange = 'NSE';
  late DateTime selectedBuyDate;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 30,
      ),
      child: SingleChildScrollView(
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              label(AppString.stock),
              AppGap.g4,
              AppFormField(
                hintText: AppString.stockName,
                controller: stockNameController,
                fillColor: AppColor.secondaryLight,
                prefixIcon: const Icon(
                  Icons.show_chart,
                  color: AppColor.textSecondary,
                ),
              ),

              AppGap.g12,

              label(AppString.stockSymbol),
              AppGap.g4,
              AppFormField(
                controller: stockSymbolController,
                hintText: AppString.stockSymbol,
                fillColor: AppColor.secondaryLight,
                prefixIcon: const Icon(
                  Icons.image,
                  color: AppColor.textSecondary,
                ),
              ),

              AppGap.g12,

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        label(AppString.stockPrice),
                        AppGap.g4,
                        AppFormField(
                          controller: buyStockController,
                          hintText: AppString.stockPrice,
                          fillColor: AppColor.secondaryLight,
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
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
                        label(AppString.stockDate),
                        AppGap.g4,
                        AppFormField(
                          hintText: AppString.stockDate,
                          controller: dateController,
                          fillColor: AppColor.secondaryLight,
                          suffix: IconButton(
                            onPressed: () async {
                              final DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime(3000),
                              );

                              if (pickedDate != null) {
                                selectedBuyDate = pickedDate;

                                dateController.text = DateFormat(
                                  'dd/MM/yyyy',
                                ).format(pickedDate);
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

              AppGap.g12,

              Row(
                children: [
                  label(AppString.quantity),
                  AppGap.g16,
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: SpinBox(
                      max: 1000,
                      min: 1,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: AppColor.secondaryLight,
                        border: OutlineInputBorder(
                          borderRadius: AppBorderRadius.cir12,
                          borderSide: BorderSide.none,
                        ),
                      ),
                      textStyle: AppTextStyles.bodyMedium(
                        color: AppColor.textPrimary,
                      ),
                      onChanged: (value) {
                        stockQuantityController.text = value.toInt().toString();
                      },
                    ),
                  ),
                ],
              ),

              AppGap.g12,

              label(AppString.selectExchange),

              RadioGroup<String>(
                groupValue: selectedExchange,
                onChanged: (value) {
                  setState(() {
                    selectedExchange = value!;
                  });
                },
                child: const Row(
                  children: [
                    Radio<String>(
                      value: AppString.nse,
                      activeColor: AppColor.primary,
                    ),
                    Text(AppString.nse),

                    AppGap.g12,

                    Radio<String>(
                      value: AppString.bse,
                      activeColor: AppColor.primary,
                    ),
                    Text(AppString.bse),
                  ],
                ),
              ),

              AppGap.g12,

              label(AppString.sector),
              StockSectorsList(
                onSectorSelected: (value) {
                  stockSectorController.text = value;
                },
              ),
              AppGap.g12,

              AppElevatedButton(
                isEnabled: true,
                text: AppString.addStock,
                onPressed: () {
                  final stockData = Stock(
                    id: const Uuid().v4(),
                    stockName: stockNameController.text.trim(),
                    stockSymbol: stockSymbolController.text.trim(),
                    buyPrice: double.parse(buyStockController.text),
                    sellPrice: 0,
                    buyDate: selectedBuyDate,
                    quantity: int.parse(stockQuantityController.text),
                    investedAmount:
                        double.parse(buyStockController.text) *
                        int.parse(stockQuantityController.text),
                    profitLoss: 0,
                    profitLossPercentage: 0,
                    sector: selectedExchange,
                    exchange: stockSectorController.text,
                  );

                  context.read<StockCubit>().createStock(
                    stockData.id,
                    stockData,
                  );
                },
              ),
            ],
          ),
        ),
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
