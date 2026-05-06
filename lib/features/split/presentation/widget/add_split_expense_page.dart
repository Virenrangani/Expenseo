import 'package:expenseo/core/constant/gap/app_gap.dart';
import 'package:expenseo/core/constant/padding/app_padding.dart';
import 'package:expenseo/core/widget/snack_bar/custom_snack_bar.dart';
import 'package:expenseo/features/split/domain/entity/group_entity.dart';
import 'package:expenseo/features/split/domain/entity/split_entity.dart';
import 'package:expenseo/features/split/presentation/cubit/split_cubit.dart';
import 'package:expenseo/features/split/presentation/cubit/split_state.dart';
import 'package:expenseo/features/split/presentation/widget/add_split_expense/split_among.dart';
import 'package:expenseo/features/split/presentation/widget/add_split_expense/split_type_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constant/colour/app_color.dart';
import '../../../../core/constant/string/app_string.dart';
import '../../../../core/constant/text_style/app_text_style.dart';
import '../../../../core/widget/amount_box/amount_box.dart';
import '../../../../core/widget/text_field/app_text_field.dart';
import 'add_split_expense/paid_by_selector.dart';

class AddSplitExpensePage extends StatefulWidget {
  final String groupId;
  final GroupEntity group;
  const AddSplitExpensePage({super.key,required this.group, required this.groupId});

  @override
  State<AddSplitExpensePage> createState() => _AddSplitExpensePageState();
}

class _AddSplitExpensePageState extends State<AddSplitExpensePage> {

  final TextEditingController amountController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final Map<String, TextEditingController> splitControllers = {};
  final formKey=GlobalKey<FormState>();

  SplitType splitType =SplitType.equal;

  String _paidByUid = '';
  String _paidByName = '';

  @override
  void initState() {
    super.initState();

    final cubit = context.read<SplitCubit>();
    _paidByUid  = cubit.currentUid;
    _paidByName = cubit.currentName;

    for (final uid in widget.group.members) {
      splitControllers[uid] = TextEditingController();
    }
  }

  Map<String, double> get _equalSplitAmong {
    final count  = widget.group.members.length;
    final share  = (double.tryParse(amountController.text) ?? 0) / count;
    return {for (final uid in widget.group.members) uid: share};
  }

  Map<String, double> get _unequalSplitAmong {
    return {
      for (final uid in widget.group.members)
        uid: double.tryParse(splitControllers[uid]!.text) ?? 0,
    };
  }

  Map<String, double> get _percentageSplitAmong {
    final total = double.tryParse(amountController.text) ?? 0;
    return {
      for (final uid in widget.group.members)
        uid: ((double.tryParse(splitControllers[uid]!.text) ?? 0) / 100) * total,
    };
  }

  Map<String, double> get finalSplitAmong {
    switch (splitType) {
      case SplitType.equal: return _equalSplitAmong;
      case SplitType.unequal: return _unequalSplitAmong;
      case SplitType.percentage: return _percentageSplitAmong;
    }
  }

  String? _validateSplit() {
    final total = double.tryParse(amountController.text) ?? 0;
    if (splitType == SplitType.unequal) {
      final sum = _unequalSplitAmong.values.fold(0.0, (a, b) => a + b);
      if ((sum - total).abs() > 0.01) {
        return 'Split amounts must equal ₹${total.toStringAsFixed(0)}';
      }
    }
    if (splitType == SplitType.percentage) {
      final sum = splitControllers.values
          .fold(0.0, (a, c) => a + (double.tryParse(c.text) ?? 0));
      if ((sum - 100).abs() > 0.01) {
        return 'Percentages must add up to 100%';
      }
    }
    return null;
  }

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
          return Form(
            key:formKey,
              child: ListView(
                padding: AppPadding.edgeAll20,
                children:[
                   AmountBox(controller: amountController,),

                  AppGap.g20,

                  buildLabel(AppString.title),
                  AppGap.g8,
                  AppFormField(
                    controller: titleController,
                    hintText: AppString.titleHint,
                    validator:  (v) =>
                    v!.trim().isEmpty ? AppString.titleInvalid : null,
                  ),

                  AppGap.g20,

                  buildLabel(AppString.paidBy),
                  AppGap.g8,
                  PaidBySelector(
                    group: widget.group,
                    selectedUid: _paidByUid,
                    onChanged: (uid, name) => setState(() {
                      _paidByUid  = uid;
                      _paidByName = name;
                    }),
                  ),

                  AppGap.g20,

                  buildLabel(AppString.splitType),
                  AppGap.g8,
                  SplitTypeSelector(selected: splitType,
                      onChanged: (t)=> setState(() {
                        splitType = t;
                      })
                  ),
                  
                  AppGap.g20,
                  
                  buildLabel(AppString.splitAmong),
                  SplitAmong(
                      group: widget.group,
                      splitType: splitType,
                      amountController: amountController,
                      splitControllers: splitControllers,
                  ),
                ],
              )
          );
        }
      ),
    );
  }

  Widget buildLabel(String text) => Text(
    text,
    style: AppTextStyles.description(),
  );
}
