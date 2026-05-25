import 'package:expenseo/features/saving/presentation/page/add_saving_goal.dart';
import 'package:flutter/material.dart';

import '../../../../core/constant/colour/app_color.dart';
import '../../../../core/constant/text_style/app_text_style.dart';

class UserSavingPage extends StatelessWidget {
  const UserSavingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Savings' , style: AppTextStyles.h4()),
      ),
      body: Container(),
      floatingActionButton: FloatingActionButton(
          onPressed: (){
            showModalBottomSheet<void>(
                context: context,
                showDragHandle: true,
                builder: (context) => const AddSavingGoal()
            );
          },
        backgroundColor: AppColor.primary,
        child: const Icon(Icons.add, color: AppColor.background ,size: 28,),
      ),
    );
  }
}
