import 'package:expenseo/features/saving/presentation/cubit/saving_cubit.dart';
import 'package:expenseo/features/saving/presentation/cubit/saving_state.dart';
import 'package:expenseo/features/saving/presentation/page/add_saving_goal.dart';
import 'package:expenseo/features/saving/presentation/page/saving_goals_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../../core/constant/colour/app_color.dart';
import '../../../../core/constant/text_style/app_text_style.dart';


class UserSavingPage extends StatelessWidget {
  const UserSavingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SavingCubit>(
      create: (_) => GetIt.I<SavingCubit>(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Savings', style: AppTextStyles.h4()),
        ),
        body: BlocBuilder<SavingCubit,SavingState>(
            builder: (context , state){
              if(state is SavingLoading){
                return const Center(child: CircularProgressIndicator(),);
              }

              if(state is SavingError){
                return Center(child: Text(state.message),);
              }

              if(state is SavingLoaded){
                return SavingGoalsList(savingGoals: state.goals);
              }

              return const SizedBox.shrink();
            }
        ),

        floatingActionButton: Builder(
          builder: (context) {
            return FloatingActionButton(
              onPressed: () {
                final savingCubit = context.read<SavingCubit>();
                showModalBottomSheet<void>(
                    context: context,
                    showDragHandle: true,
                    builder: (context) =>
                        BlocProvider.value(
                          value: savingCubit,
                          child: const AddSavingGoal(),
                        )
                );
              },
              backgroundColor: AppColor.primary,
              child: const Icon(Icons.add, color: AppColor.background, size: 28,),
            );
          }
        ),
      ),
    );
  }
}
