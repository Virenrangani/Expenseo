import 'package:expenseo/features/saving/domain/entity/saving_goal.dart';
import 'package:expenseo/features/saving/presentation/cubit/saving_cubit.dart';
import 'package:expenseo/features/saving/presentation/cubit/saving_state.dart';
import 'package:expenseo/features/saving/presentation/widget/deposit_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GoalDetailPage extends StatelessWidget {
  final SavingGoal goal;

  const GoalDetailPage({super.key, required this.goal});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          context.read<SavingCubit>().getAllGoal();
        }
      },
      child: Scaffold(
        body: BlocBuilder<SavingCubit, SavingState>(
          builder: (context, state) {
            if (state is SavingLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is SavingError) {
              return Center(child: Text(state.message));
            }

            if (state is DepositLoaded) {
              return DepositList(deposits: state.deposits, goal: goal);
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
