import 'package:flutter/material.dart';

import '../../../../core/constant/colour/app_color.dart';
import '../../../../core/constant/string/app_string.dart';
import '../../../../core/constant/text_style/app_text_style.dart';

class AddSplitExpensePage extends StatefulWidget {
  const AddSplitExpensePage({super.key});

  @override
  State<AddSplitExpensePage> createState() => _AddSplitExpensePageState();
}

class _AddSplitExpensePageState extends State<AddSplitExpensePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.background,
        leading: IconButton(
          icon:const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(AppString.addExpense, style: AppTextStyles.h5()),
      ),
    );
  }
}
