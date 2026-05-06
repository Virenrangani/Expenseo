import 'package:expenseo/core/widget/snack_bar/custom_snack_bar.dart';
import 'package:expenseo/features/split/presentation/cubit/split_cubit.dart';
import 'package:expenseo/features/split/presentation/cubit/split_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      body:BlocConsumer<SplitCubit,SplitState>(

        listener: (context,state){

          if(state is SplitSuccess){
            CustomSnacksBar.showSuccess(context,state.message);
          }

          if(state is SplitError){
            CustomSnacksBar.showError(context, state.message);
          }
        },

        builder: (context,state){
          return const SizedBox.shrink();
        }
      ),
    );
  }
}
