import 'package:expenseo/core/constant/border_radius/app_border_radius.dart';
import 'package:expenseo/core/constant/colour/app_color.dart';
import 'package:expenseo/core/constant/gap/app_gap.dart';
import 'package:expenseo/core/constant/padding/app_padding.dart';
import 'package:expenseo/core/extension/localization_extension.dart';
import 'package:expenseo/core/navigation/app_navigation.dart';
import 'package:expenseo/features/split/presentation/cubit/split_state.dart';
import 'package:expenseo/features/split/presentation/widget/group_details_view/group_expense_page.dart';
import 'package:flutter/material.dart';

import '../../../../core/constant/text_style/app_text_style.dart';
import '../../../../core/widget/format_amount/format_amount.dart';
import 'group_details_view/show_settle_dialog.dart';

class GroupDetailsView extends StatelessWidget {
  final GroupDetailLoaded state;
  final Map<String, double> balance;

  const GroupDetailsView({
    super.key,
    required this.state,
    required this.balance,
  });

  @override
  Widget build(BuildContext context) {
    final totalGroupExpense = state.expenses.fold(
      0.0,
      (sum, e) => sum + e.amount,
    );

    return SafeArea(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTopSummaryCard(totalGroupExpense, context),

            AppGap.g24,

            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(
                    top: 32,
                    left: 16,
                    right: 16,
                    bottom: 16,
                  ),
                  margin: const EdgeInsets.only(top: 24, left: 16, right: 16),
                  decoration: BoxDecoration(
                    color: AppColor.textPrimary,
                    borderRadius: AppBorderRadius.cir20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (balance.isEmpty)
                        Center(
                          child: Text(
                            context.l10n.allBalancesSettled,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        )
                      else
                        _buildVerticalBalances(context),
                    ],
                  ),
                ),

                Positioned(
                  top: 0,
                  right: 40,
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.list_alt_outlined,
                        color: AppColor.primary,
                        size: 30,
                      ),
                      onPressed: () {
                        context.push(
                          GroupExpensesPage(expenses: state.expenses),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),

            AppGap.g32,
          ],
        ),
      ),
    );
  }

  Widget _buildTopSummaryCard(double totalExpense, BuildContext context) {
    return Padding(
      padding: AppPadding.edgeSymmetricHori16,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(context.l10n.totalGroupExpense, style: AppTextStyles.h5()),
                AppGap.g4,
                Text(formatAmount(totalExpense), style: AppTextStyles.h2()),
                AppGap.g8,
                Row(
                  children: [
                    const Icon(
                      Icons.pie_chart,
                      size: 16,
                      color: AppColor.primaryLight,
                    ),
                    const SizedBox(width: 4),
                    Text(state.group.name, style: AppTextStyles.titleLarge()),
                  ],
                ),
              ],
            ),
          ),

          Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey.shade100,
              border: Border.all(color: Colors.grey.shade300, width: 2),
            ),
            child: Center(
              child: Text(
                state.group.name.isNotEmpty
                    ? state.group.name[0].toUpperCase()
                    : 'G',
                style: AppTextStyles.h2(color: Colors.blue.shade700),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVerticalBalances(BuildContext context) {
    double maxBalance = 0;
    for (final amount in balance.values) {
      if (amount.abs() > maxBalance) maxBalance = amount.abs();
    }
    if (maxBalance == 0) maxBalance = 1;

    final colors = [
      Colors.deepPurpleAccent,
      Colors.teal,
      Colors.orange,
      Colors.indigo,
      Colors.pinkAccent,
      Colors.lightBlue,
    ];

    return SizedBox(
      height: 280,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: balance.length,
        itemBuilder: (context, index) {
          final uid = balance.keys.elementAt(index);
          final amount = balance[uid]!;
          final memberName = state.group.memberNames[uid] ?? 'Unknown';

          final lineColor = colors[index % colors.length];

          final fillPercentage = (amount.abs() / maxBalance).clamp(0.15, 1.0);

          return _buildSingleBalanceLine(
            context: context,
            uid: uid,
            name: memberName,
            amount: amount,
            color: lineColor,
            fillPercentage: fillPercentage,
          );
        },
      ),
    );
  }

  Widget _buildSingleBalanceLine({
    required BuildContext context,
    required String uid,
    required String name,
    required double amount,
    required Color color,
    required double fillPercentage,
  }) {
    final shortName = name.split(' ').first;

    return GestureDetector(
      onTap: () {
        showSettleDialog(
          context: context,
          group: state.group,
          uid: uid,
          name: name,
          amount: amount,
        );
      },
      child: Container(
        width: 80,
        margin: const EdgeInsets.only(right: 8),
        child: Column(
          children: [
            Text(
              shortName,
              style: AppTextStyles.captionBold(color: AppColor.background),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            AppGap.g8,

            CircleAvatar(
              radius: 20,
              backgroundColor: color.withAlpha(50),
              child: Text(
                shortName.isNotEmpty ? shortName[0].toUpperCase() : '?',
                style: TextStyle(color: color, fontWeight: FontWeight.bold),
              ),
            ),
            AppGap.g4,

            Expanded(
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Container(
                    width: 4,
                    decoration: BoxDecoration(
                      color: color.withAlpha(30),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),

                  FractionallySizedBox(
                    heightFactor: fillPercentage,
                    alignment: Alignment.topCenter,
                    child: Column(
                      children: [
                        Expanded(
                          child: Container(
                            width: 4,
                            decoration: BoxDecoration(
                              color: color,
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                        ),
                        Container(
                          height: 12,
                          width: 12,
                          decoration: BoxDecoration(
                            color: color,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColor.textPrimary,
                              width: 2,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            AppGap.g8,

            Text(
              amount > 0
                  ? context.l10n.owesYou
                  : (amount < 0 ? context.l10n.youOwe : context.l10n.settled),
              style: AppTextStyles.captionBold(
                color: amount > 0
                    ? AppColor.success
                    : (amount < 0 ? Colors.red : Colors.grey),
              ),
            ),
            Text(
              formatAmount(amount.abs()),
              style: AppTextStyles.captionBold(color: color),
            ),
          ],
        ),
      ),
    );
  }
}
