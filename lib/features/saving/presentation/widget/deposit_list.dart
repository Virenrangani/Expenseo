import 'package:expenseo/features/saving/presentation/widget/deposit_tile.dart';
import 'package:flutter/material.dart';

import '../../domain/entity/deposit.dart';

class DepositList extends StatelessWidget {
  final List<Deposit> deposits;
  const DepositList({super.key, required this.deposits});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: deposits.length,
        itemBuilder: (context, index){
          final deposit = deposits[index];
          return DepositTile(deposit: deposit,);
        }
    );
  }
}
