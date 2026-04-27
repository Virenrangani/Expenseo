import 'package:flutter/material.dart';

import '../../../../core/constant/colour/app_color.dart';
import '../../../../core/constant/gap/app_gap.dart';
import '../../../../core/constant/text_style/app_text_style.dart';

class TransactionList extends StatelessWidget {
  const TransactionList({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> data = [
      {
        'title': 'Shopping',
        'subtitle': 'Amazon',
        'time': '10:30 AM',
        'amount': '-₹500',
        'icon': Icons.shopping_cart,
      },
      {
        'title': 'Salary',
        'subtitle': 'Company',
        'time': '09:00 AM',
        'amount': '+₹50,000',
        'icon': Icons.account_balance_wallet,
      },
      {
        'title': 'Food',
        'subtitle': 'Zomato',
        'time': '08:15 PM',
        'amount': '-₹250',
        'icon': Icons.fastfood,
      },
    ];
    return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          final item = data[index];

          return ListTile(
            leading: CircleAvatar(
              radius: 24,
              child: Icon(
                item['icon'] as IconData,
                color: AppColor.primary,
              ),
            ),

            title: Text(
              item['title'] as String,
              style: AppTextStyles.h4()
            ),

            subtitle: Row(
              children: [
                Expanded(child: Text(item['subtitle'] as String,style: AppTextStyles.bodyMedium(),)),
                AppGap.g8,
                const Text('•'),
                AppGap.g8,
                Text(
                  item['time'] as String,
                  style: AppTextStyles.captionMedium(),
                ),
              ],
            ),

            trailing: Text(
              item['amount'] as String,
              style: AppTextStyles.h5(
                color:item['amount'].toString().startsWith('-')
                  ? AppColor.error
                  : AppColor.success,
              )
            ),
          );
        },
      );
  }
}
