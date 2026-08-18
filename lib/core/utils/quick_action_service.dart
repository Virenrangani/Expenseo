import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:quick_actions/quick_actions.dart';

import '../../features/expense/presentation/cubit/expense_cubit.dart';
import '../../features/expense/presentation/page/add_expense_sheet.dart';
import '../../main.dart';
import '../storage/shared_pref/shared_pref_service.dart';

enum QuickActionType {
  addExpense('add_expense', 'Add Expense', 'add_ic');

  const QuickActionType(this.id, this.title, this.icon);
  final String id;
  final String title;
  final String icon;
}

class QuickActionService {
  static const QuickActions _quickActions = QuickActions();

  static void init() {
    _quickActions.initialize((shortcutType) {
      final action = QuickActionType.values.firstWhere(
        (e) => e.id == shortcutType,
        orElse: () => QuickActionType.addExpense,
      );
      _handleQuickAction(action);
    });

    _quickActions.setShortcutItems(
      QuickActionType.values
          .map(
            (action) => ShortcutItem(
              type: action.id,
              localizedTitle: action.title,
              icon: action.icon,
            ),
          )
          .toList(),
    );
  }

  static void _handleQuickAction(QuickActionType action) {
    if (!SharedPrefService.isLoggedIn()) {
      return;
    }

    final context = appNavigatorKey.currentContext;
    if (context == null) return;

    switch (action) {
      case QuickActionType.addExpense:
        _showAddExpense(context);
    }
  }

  static void _showAddExpense(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      showDragHandle: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => BlocProvider.value(
        value: GetIt.I<ExpenseCubit>(),
        child: const AddExpenseSheet(),
      ),
    );
  }
}
