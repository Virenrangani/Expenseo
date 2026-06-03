import 'package:expenseo/core/constant/text_style/app_text_style.dart';
import 'package:expenseo/features/investment/main_page/stocks/presentation/cubit/stock_cubit.dart';
import 'package:expenseo/features/investment/main_page/stocks/presentation/cubit/stock_state.dart';
import 'package:expenseo/features/investment/main_page/stocks/presentation/page/stock_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../../../../core/constant/colour/app_color.dart';
import 'add_stock_page.dart';

class StocksPage extends StatefulWidget {
  final String title;

  const StocksPage({super.key, required this.title});

  @override
  State<StocksPage> createState() => _StocksPageState();
}

class _StocksPageState extends State<StocksPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<StockCubit>(
      create: (_) => GetIt.I<StockCubit>(),
      child: Scaffold(
        appBar: AppBar(title: Text(widget.title, style: AppTextStyles.h4())),
        body: Column(
          children: [
            Expanded(
              child: BlocBuilder<StockCubit, StockState>(
                builder: (context, state) {
                  if (state is StockLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state is StockLoaded) {
                    return StockDetailPage(stocks: state.stocks);
                  }

                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColor.primary,
          foregroundColor: AppColor.background,
          onPressed: () {
            showModalBottomSheet<void>(
              context: context,
              showDragHandle: true,
              builder: (context) {
                return const AddStockPage();
              },
            );
          },
          child: const Icon(Icons.add, size: 28),
        ),
      ),
    );
  }
}
