import 'package:expenseo/features/saving/presentation/cubit/saving_cubit.dart';
import 'package:expenseo/features/saving/presentation/page/add_saving_goal.dart';
import 'package:expenseo/features/saving/presentation/page/saving_goals_list.dart';
import 'package:expenseo/features/saving/presentation/widget/goal_empty_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../../core/constant/colour/app_color.dart';
import '../../../../core/constant/text_style/app_text_style.dart';
import '../../../../core/storage/shared_pref/shared_pref_service.dart';
import '../../../../core/widget/login_required_dialog/login_required_dialog.dart';
import '../cubit/saving_state.dart';

class UserSavingPage extends StatelessWidget {
  const UserSavingPage({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SavingCubit>(create: (_) => GetIt.I<SavingCubit>()),
        // BlocProvider<DepositCubit>(create: (_) => GetIt.I<DepositCubit>()),
      ],
      child: Scaffold(
        appBar: AppBar(title: Text('Savings', style: AppTextStyles.h4())),
        body: BlocBuilder<SavingCubit, SavingState>(
          builder: (context, state) {
            if (state is SavingLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is SavingError) {
              return Center(child: Text(state.message));
            }

            if (state is SavingLoaded) {
              if (state.goals.isEmpty) {
                return const GoalEmptyState();
              }

              return SavingGoalsList(savingGoals: state.goals);
            }

            return const SizedBox.shrink();
          },
        ),

        floatingActionButton: Builder(
          builder: (context) {
            return FloatingActionButton(
              onPressed: () {
                if (SharedPrefService.isGuest()) {
                  LoginRequiredDialog.show(context, 'Saving Goals');
                  return;
                }
                showModalBottomSheet<void>(
                  context: context,
                  showDragHandle: true,
                  builder: (context) => const AddSavingGoal(),
                );
              },
              backgroundColor: AppColor.primary,
              child: const Icon(
                Icons.add,
                color: AppColor.background,
                size: 28,
              ),
            );
          },
        ),
      ),
    );
  }
}

// SavingGoalsList(
// savingGoals: [
// SavingGoal(
// id: "1",
// goal: "",
// goalImage:
// "https://static.vecteezy.com/system/resources/thumbnails/057/068/323/small/single-fresh-red-strawberry-on-table-green-background-food-fruit-sweet-macro-juicy-plant-image-photo.jpg",
// targetAmount: 1,
// savedAmount: 1,
// isCompleted: false,
// createdAt: DateTime.now(),
// ),
// ],
// ),
