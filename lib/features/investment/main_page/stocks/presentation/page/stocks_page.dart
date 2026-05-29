import 'package:expenseo/core/constant/text_style/app_text_style.dart';
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
      body: Container(),
    );
  }
}
