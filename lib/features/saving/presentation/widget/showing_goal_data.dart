import 'package:expenseo/features/saving/domain/entity/saving_goal.dart';
import 'package:expenseo/features/saving/presentation/cubit/saving_cubit.dart';
import 'package:expenseo/features/saving/presentation/cubit/saving_state.dart';
import 'package:expenseo/features/saving/presentation/widget/deposit_list.dart';
import 'package:expenseo/features/saving/presentation/widget/goal_detail_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constant/colour/app_color.dart';

class ShowingGoalData extends StatefulWidget {
  final SavingGoal goal;

  const ShowingGoalData({super.key, required this.goal});

  @override
  State<ShowingGoalData> createState() => _ShowingGoalDataState();
}

class _ShowingGoalDataState extends State<ShowingGoalData> {
  bool showDepositTitle = false;
  double sheetSize = 0.55;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: widget.goal.id,
      child: Material(
        color: Colors.transparent,
        child: Stack(
          children: [
            Opacity(
              opacity: (1 - (sheetSize - 0.55) / 0.45).clamp(0.0, 1.0),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.50,
                width: double.infinity,
                child: ShaderMask(
                  shaderCallback: (bounds) {
                    return LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        AppColor.textPrimary.withAlpha(230),
                        AppColor.textPrimary.withAlpha(180),
                        AppColor.textPrimary.withAlpha(50),
                        Colors.transparent,
                      ],
                      stops: const [0.15, 0.3, 0.5, 1.0],
                    ).createShader(bounds);
                  },
                  blendMode: BlendMode.darken,
                  child: Image.network(
                    widget.goal.goalImage,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),

            GoalDetailAppBar(showDepositTitle: showDepositTitle),

            BlocBuilder<SavingCubit, SavingState>(
              bloc: context.read<SavingCubit>(),
              builder: (context, state) {
                if (state is SavingLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is SavingError) {
                  return Center(child: Text(state.message));
                }

                if (state is DepositLoaded) {
                  return DepositList(
                    deposits: state.deposits,
                    showDepositTitle: showDepositTitle,
                    sheetSize: sheetSize,
                    onTitleVisibilityChanged: (value) {
                      setState(() {
                        showDepositTitle = value;
                      });
                    },
                  );
                }

                return const SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }
}
