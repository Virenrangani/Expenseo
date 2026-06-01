import 'package:expenseo/core/constant/colour/app_color.dart';
import 'package:expenseo/core/constant/text_style/app_text_style.dart';
import 'package:expenseo/features/investment/main_page/stocks/presentation/page/add_stock_page.dart';
import 'package:flutter/material.dart';

class StocksPage extends StatefulWidget {
  final String title;

  const StocksPage({super.key, required this.title});

  @override
  State<StocksPage> createState() => _StocksPageState();
}

class _StocksPageState extends State<StocksPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title, style: AppTextStyles.h4())),
      body: Stack(
        children: [
          Positioned(
            bottom: 38,
            right: 28,
            child: FloatingActionButton(
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
        ],
      ),
    );
  }
}
