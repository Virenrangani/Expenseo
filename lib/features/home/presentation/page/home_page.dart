import 'package:flutter/material.dart';
import '../../../../core/constant/colour/app_color.dart';
import '../../../../core/constant/gap/app_gap.dart';
import '../../../../core/constant/padding/app_padding.dart';
import '../../../../core/constant/string/app_string.dart';
import '../../../../core/constant/text_style/app_text_style.dart';
import '../../../../core/widget/app_title/app_title.dart';
import '../../../../core/widget/app_icon_card/app_icon_card.dart';
import 'package:expenseo/features/home/presentation/widget/transaction_list.dart';
import 'package:expenseo/features/home/presentation/widget/greeting_user.dart';
import 'package:expenseo/features/home/presentation/widget/expense_container.dart';
import 'package:expenseo/features/expense/presentation/page/user_expense_page.dart';
import 'package:expenseo/features/split_expense/presentation/page/split_expense_page.dart';
import '../../../../core/storage/shared_pref/shared_pref_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String userName = "";

  @override
  void initState() {
    super.initState();
    loadUserName();
  }

  Future<void> loadUserName() async {
    final name = await SharedPrefService.getUserName();
    setState(() {
      userName = name ?? "User";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: AppPadding.edgeSymmetricHori16,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppTitle(style: AppTextStyles.h3(color: AppColor.secondary)),
              AppGap.g16,
              GreetingUser(userName: userName),
              AppGap.g20,
              ExpenseContainer(),
              AppGap.g24,
              Row(
                children: [
                  Expanded(
                      child:AppIconCard(
                        icon: Icons.add_circle_outline_outlined,
                        text: AppString.addExpense,
                        onTap: (){
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context)=>UserExpensePage()));
                        },
                      ),
                  ),
                  AppGap.g16,
                  Expanded(
                    child:AppIconCard(
                      icon: Icons.splitscreen,
                      text: AppString.split,
                      onTap: (){
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context)=>UserExpensePage()));
                      },
                    ),
                  ),
                ],
              ),
              AppGap.g32,
              Text(AppString.recentTransaction,
                style: AppTextStyles.captionBold(color:AppColor.textPrimary),),

              AppGap.g16,

              Expanded(child: TransactionList())
            ],
          ),
        ),
      ),
    );
  }
}