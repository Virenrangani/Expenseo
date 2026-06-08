import 'package:flutter/material.dart';

import '../../domain/entity/investment.dart';

final List<InvestmentModel> investments = [
  InvestmentModel(title: 'Stocks', icon: Icons.show_chart, color: Colors.blue),
  InvestmentModel(
    title: 'F&O',
    icon: Icons.candlestick_chart,
    color: Colors.orange,
  ),
  InvestmentModel(
    title: 'Mutual Fund',
    icon: Icons.account_balance,
    color: Colors.green,
  ),
  InvestmentModel(
    title: 'Gold',
    icon: Icons.workspace_premium,
    color: Colors.amber,
  ),
  InvestmentModel(title: 'Silver', icon: Icons.circle, color: Colors.grey),
  InvestmentModel(
    title: 'Crypto',
    icon: Icons.currency_bitcoin,
    color: Colors.deepPurple,
  ),
  InvestmentModel(title: 'ETF', icon: Icons.bar_chart, color: Colors.teal),
  InvestmentModel(
    title: 'Bonds',
    icon: Icons.receipt_long,
    color: Colors.indigo,
  ),
  InvestmentModel(
    title: 'IPO',
    icon: Icons.trending_up,
    color: Colors.redAccent,
  ),
  InvestmentModel(
    title: 'Real Estate',
    icon: Icons.home_work,
    color: Colors.brown,
  ),
  InvestmentModel(title: 'NPS', icon: Icons.savings, color: Colors.pink),
  InvestmentModel(title: 'FD', icon: Icons.lock, color: Colors.cyan),
];
