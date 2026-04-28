import '../../../../core/enums/app_enums.dart';

class Expense {
  final String id;
  final String title;
  final double amount;
  final TransactionType type;
  final ExpenseCategory category;
  final PaymentMethod paymentMethod;
  final DateTime createdAt;

  Expense({
    required this.id,
    required this.title,
    required this.amount,
    required this.type,
    required this.category,
    required this.paymentMethod,
    required this.createdAt,
  });
}