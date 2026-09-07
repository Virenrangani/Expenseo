import '../../../../core/enums/app_enums.dart';
import '../../../../core/utils/date_time_utils.dart';

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
      id: json['id']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      amount: (json['amount'] as num?)?.toDouble() ?? 0.0,
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
      createdAt: DateTimeUtils.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'amount': amount,
      'expenseCategory': category.key,
      'expenseType': type.key,
      'transactionType': paymentMethod.key,
      'createdAt': createdAt.toUtc().toIso8601String(),
    };
  }
}
