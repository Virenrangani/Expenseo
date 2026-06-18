
import '../../../../core/enums/app_enums.dart';

class ExpenseModel {
  final String id;
  final String title;
  final double amount;
  final ExpenseCategory category;
  final TransactionType type;
  final PaymentMethod paymentMethod;
  final DateTime createdAt;

  ExpenseModel({
    required this.id,
    required this.title,
    required this.amount,
    required this.category,
    required this.type,
    required this.paymentMethod,
    required this.createdAt,
  });

  factory ExpenseModel.fromJson(Map<String, dynamic> json) {
    return ExpenseModel(
      id: json['id'] as String,
      title: json['title'] as String,
      amount: (json['amount'] as num).toDouble(),
      category: ExpenseCategory.values.firstWhere(
        (e) => e.key == json['expenseCategory'],
        orElse: () => ExpenseCategory.other,
      ),
      type: TransactionType.values.firstWhere(
        (e) => e.key == json['expenseType'],
        orElse: () => TransactionType.expense,
      ),
      paymentMethod: PaymentMethod.values.firstWhere(
        (e) => e.key == json['transactionType'],
        orElse: () => PaymentMethod.cash,
      ),
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'amount': amount,
      'expenseCategory': category.key,
      'expenseType': type.key,
      'transactionType': paymentMethod.key,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
