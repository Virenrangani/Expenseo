import 'package:expenseo/di/injection.dart';
import 'package:expenseo/features/saving/domain/entity/saving_goal.dart';
import 'package:expenseo/features/saving/presentation/cubit/deposit_cubit.dart';
import 'package:expenseo/features/saving/presentation/widget/showing_goal_data.dart';
import 'package:flutter/material.dart';

class GoalDetailPage extends StatefulWidget {
  final SavingGoal goal;

  const GoalDetailPage({super.key, required this.goal});

  @override
  State<GoalDetailPage> createState() => _GoalDetailPageState();
}

class _GoalDetailPageState extends State<GoalDetailPage> {
  @override
  void initState() {
    super.initState();
    Injection.sl<DepositCubit>().getAllDeposit(widget.goal.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: ShowingGoalData(goal: widget.goal));
  }
}
