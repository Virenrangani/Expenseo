import 'package:expenseo/core/constant/text_style/app_text_style.dart';
import 'package:expenseo/features/saving/presentation/cubit/saving_cubit.dart';
import 'package:expenseo/features/saving/presentation/cubit/saving_state.dart';
import 'package:expenseo/features/saving/presentation/widget/deposit_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GoalDetailPage extends StatelessWidget {
  const GoalDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Deposit History' , style: AppTextStyles.h4(),),
      ),
      body: BlocBuilder<SavingCubit , SavingState>(
          builder: (context , state){
            if (state is SavingLoading){
              return const Center(child: CircularProgressIndicator());
            }

            if(state is SavingError){
              return Center(child: Text(state.message),);
            }

            if(state is DepositLoaded){
              return DepositList(deposits: state.deposits);
            }

            return const SizedBox.shrink();
          }
      )
    );
  }
}
