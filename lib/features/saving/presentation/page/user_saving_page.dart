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
        actions: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal:18),
            decoration: const BoxDecoration(
              color: AppColor.primary,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              onPressed: () {
                showModalBottomSheet<void>(
                    context: context,
                    showDragHandle: true,
                    builder: (context) => const AddSavingGoal()
                );
              },
              icon: const Icon(Icons.add, color: AppColor.background),
            ),
          ),
        ],
      ),
      body: Container(),
    );
  }
}
