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
import 'package:uuid/uuid.dart';

import '../../../../core/constant/colour/app_color.dart';
import '../../../../core/constant/string/app_string.dart';
import '../../../../core/constant/text_style/app_text_style.dart';
import '../../../../core/widget/amount_box/amount_box.dart';
import '../../../../core/widget/elevated_button/app_elevated_button.dart';
import '../../../../core/widget/text_field/app_text_field.dart';
import 'add_split_expense/paid_by_selector.dart';

class AddSplitExpensePage extends StatefulWidget {
  final GroupEntity group;
  const AddSplitExpensePage({super.key , required this.group});

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
        return '${AppString.splitAmountNotEquals}₹${total.toStringAsFixed(0)}';
      }
    }
    if (splitType == SplitType.percentage) {
      final sum = splitControllers.values
          .fold(0.0, (a, c) => a + (double.tryParse(c.text) ?? 0));
      if ((sum - 100).abs() > 0.01) {
        return AppString.splitAmountMust100Per;
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
          final isLoading=state is SplitLoading;
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

                  AppGap.g20,

                  AppElevatedButton(
                    text: AppString.addExpense,
                    isLoading: isLoading,
                    isEnabled: true,
                    onPressed: onSubmit,
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

  void onSubmit() {
    if (!formKey.currentState!.validate()) return;

    final splitError = _validateSplit();
    if (splitError != null) {
      CustomSnacksBar.showError(context, splitError);
      return;
    }

    context.read<SplitCubit>().addSplitExpense(
      SplitEntity(
          id: const Uuid().v4(),
          groupId: widget.group.id,
          title: titleController.text.trim(),
          amount: double.parse(amountController.text.trim()),
          paidBy: _paidByUid,
          paidByName: _paidByName,
          splitAmong: finalSplitAmong,
          splitType: splitType,
          createdAt: DateTime.now()
      )
    );
  }
}
