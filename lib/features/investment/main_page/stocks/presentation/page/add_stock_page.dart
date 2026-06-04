import 'package:expenseo/core/constant/border_radius/app_border_radius.dart';
import 'package:expenseo/core/constant/colour/app_color.dart';
import 'package:expenseo/core/constant/gap/app_gap.dart';
import 'package:expenseo/core/constant/text_style/app_text_style.dart';
import 'package:expenseo/core/widget/elevated_button/app_elevated_button.dart';
import 'package:expenseo/core/widget/text_field/app_text_field.dart';
import 'package:expenseo/di/injection.dart';
import 'package:expenseo/features/investment/main_page/stocks/domain/entity/stock.dart';
import 'package:expenseo/features/investment/main_page/stocks/presentation/cubit/stock_cubit.dart';
import 'package:expenseo/features/investment/main_page/stocks/presentation/widget/stock_sectors_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'package:intl/intl.dart';

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
    final cubit = Injection().sl<StockCubit>();
    return BlocProvider.value(
      value: cubit,
      child: Padding(
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
                label('Stock'),
                AppGap.g4,
                AppFormField(
                  hintText: 'Stock name',
                  controller: stockNameController,
                  fillColor: AppColor.secondaryLight,
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
                          label('Buy Price'),
                          AppGap.g4,
                          AppFormField(
                            controller: buyStockController,
                            hintText: 'Buy Price',
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
                          label('Buy Date'),
                          AppGap.g4,
                          AppFormField(
                            hintText: 'Buy Date',
                            controller: dateController,
                            fillColor: AppColor.secondaryLight,
                            suffix: IconButton(
                              onPressed: () async {
                                final DateTime? pickedDate =
                                    await showDatePicker(
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
                    label('Quantity'),
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
                          stockQuantityController.text = value
                              .toInt()
                              .toString();
                        },
                      ),
                    ),
                  ],
                ),

                AppGap.g12,

                label('Select Exchange'),

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
                        value: 'NSE',
                        activeColor: AppColor.primary,
                      ),
                      Text('NSE'),

                      AppGap.g12,

                      Radio<String>(
                        value: 'BSE',
                        activeColor: AppColor.primary,
                      ),
                      Text('BSE'),
                    ],
                  ),
                ),

                AppGap.g12,

                label('Sector'),
                StockSectorsList(
                  onSectorSelected: (value) {
                    stockSectorController.text = value;
                  },
                ),
                AppGap.g12,

                AppElevatedButton(
                  isEnabled: true,
                  text: 'Add Stock',
                  onPressed: () {
                    final stockData = Stock(
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

                    cubit.createStock(stockData);
                  },
                ),
              ],
            ),
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
