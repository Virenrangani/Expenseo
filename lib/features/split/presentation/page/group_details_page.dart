import 'package:expenseo/core/constant/colour/app_color.dart';
import 'package:expenseo/core/widget/snack_bar/custom_snack_bar.dart';
import 'package:expenseo/features/split/domain/entity/group_entity.dart';
import 'package:expenseo/features/split/presentation/cubit/split_cubit.dart';
import 'package:expenseo/features/split/presentation/cubit/split_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widget/add_split_expense_page.dart';

class GroupDetailsPage extends StatefulWidget {
  final String groupId;
  final GroupEntity group;
  const GroupDetailsPage({super.key , required this.group, required this.groupId});

  @override
  State<GroupDetailsPage> createState() => _GroupDetailsPageState();
}

class _GroupDetailsPageState extends State<GroupDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryLight,
      body:BlocConsumer<SplitCubit,SplitState>(
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
            return const SizedBox.shrink();
          }
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColor.secondary,
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute<void>(
            builder: (_) => BlocProvider.value(
              value: context.read<SplitCubit>(),
              child:  AddSplitExpensePage(group: widget.group, groupId: widget.groupId,),
            ),
          ),
        ),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
