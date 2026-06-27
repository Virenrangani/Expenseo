import 'package:expenseo/core/constant/colour/app_color.dart';
import 'package:expenseo/core/constant/padding/app_padding.dart';
import 'package:expenseo/core/widget/elevated_button/app_elevated_button.dart';
import 'package:expenseo/core/widget/snack_bar/custom_snack_bar.dart';
import 'package:expenseo/features/split/domain/entity/group_entity.dart';
import 'package:expenseo/features/split/presentation/cubit/split_cubit.dart';
import 'package:expenseo/features/split/presentation/cubit/split_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widget/add_split_expense_page.dart';
import '../widget/group_details_view.dart';

class GroupDetailsPage extends StatefulWidget {
  final GroupEntity group;
  const GroupDetailsPage({super.key , required this.group});

  @override
  State<GroupDetailsPage> createState() => _GroupDetailsPageState();
}

class _GroupDetailsPageState extends State<GroupDetailsPage> {

  @override
  void initState() {
    super.initState();
    context.read<SplitCubit>().loadGroupDetail(widget.group);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {

        if (didPop) {
          context.read<SplitCubit>().getGroups();
        }
      },
      child: Scaffold(
        backgroundColor: AppColor.background,
        body:Column(
          children: [
            Expanded(
              child: BlocConsumer<SplitCubit,SplitState>(
                  listener:(context,state){
              
                    if(state is SplitSuccess){
                      CustomSnacksBar.showSuccess(context, state.message);
                    }
              
                    if(state is SplitError){
                      CustomSnacksBar.showError(context, state.message);
                    }
                  },
                  builder: (context,state){
              
                    if(state is SplitLoading){
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
              
                    if(state is GroupDetailLoaded){
                      final uid = context.read<SplitCubit>().currentUid;
                      final balances = state.calculateBalances(uid);
                      return GroupDetailsView(state:state,balance:balances);
                    }
                    return const SizedBox.shrink();
                  }
              ),
            ),
            Padding(
              padding: AppPadding.edgeAll12,
              child: AppElevatedButton(
                  text: 'Add Group Expense....',
                  onPressed: () => Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (_) => BlocProvider.value(
                    value: context.read<SplitCubit>(),
                    child:  AddSplitExpensePage(group: widget.group),
                  ),
                ),
              )
              ),
            )
          ],
        ),
      ),
    );
  }
}
