import 'package:expenseo/core/constant/colour/app_color.dart';
import 'package:expenseo/core/widget/snack_bar/custom_snack_bar.dart';
import 'package:expenseo/features/split/presentation/cubit/split_cubit.dart';
import 'package:expenseo/features/split/presentation/cubit/split_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GroupDetailsPage extends StatefulWidget {
  const GroupDetailsPage({super.key});

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
    );
  }
}
