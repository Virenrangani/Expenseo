import 'package:expenseo/core/constant/gap/app_gap.dart';
import 'package:expenseo/core/constant/padding/app_padding.dart';
import 'package:expenseo/core/constant/string/app_string.dart';
import 'package:expenseo/features/split/presentation/cubit/split_state.dart';
import 'package:expenseo/features/split/presentation/widget/empty_state.dart';
import 'package:expenseo/features/split/presentation/widget/group_details_view/member_row.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/constant/colour/app_color.dart';
import '../../../../core/constant/text_style/app_text_style.dart';
import 'group_details_view/balance_card.dart';
import 'group_details_view/expense_section.dart';
import 'group_details_view/settled_card.dart';
import 'group_details_view/show_settle_dialog.dart';

class GroupDetailsView extends StatelessWidget {
  final GroupDetailLoaded state;
  final Map<String, double> balance;
  const GroupDetailsView({super.key, required this.state, required this.balance});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SingleChildScrollView(
          padding: AppPadding.edgeAll12,
          child: Column(
            children: [

              Text(
                state.group.name,
                style: AppTextStyles.h4(),
              ),

              AppGap.g16,
              
              MemberRow(group: state.group),

              AppGap.g20,

            Text(AppString.balance,
                style: AppTextStyles.captionBold(
                    color: AppColor.textPrimary)),

            AppGap.g8,

            if (balance.isEmpty)
               const SettledCard()
            else
              ...balance.entries.map((entry) {
                final memberName =
                    state.group.memberNames[entry.key] ?? '';

                return BalanceCard(
                  uid: entry.key,
                  name: memberName,
                  amount: entry.value,
                  groupId: state.group.id,
                  onSettle: () => showSettleDialog(
                    context: context,
                    groupId:state.group.id,
                    uid: entry.key,
                    name: memberName,
                    amount: entry.value,
                  ),
                );
              }),

              AppGap.g20,

              Text(AppString.expense,
                  style: AppTextStyles.captionBold(
                      color: AppColor.textPrimary
                  )
              ),

              AppGap.g8,

              if (state.expenses.isEmpty)
                const EmptyState()
              else
                ExpenseSection(expenses: state.expenses)
            ],
          )
        )
    );
  }
}
