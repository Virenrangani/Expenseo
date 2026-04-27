import 'package:cloud_firestore/cloud_firestore.dart';
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


  factory ExpenseModel.fromJson(String id, Map<String, dynamic> json) {
    return ExpenseModel(
      id: id,
      title: json['title'],
      amount: (json['amount'] as num).toDouble(),
      category: ExpenseCategory.values.firstWhere(
            (e) => e.key == json['category'],
        orElse: () => ExpenseCategory.other,
      ),
      type: TransactionType.values.firstWhere(
              (e) => e.key == json['type'],
        orElse: () => TransactionType.expense,
      ),
      paymentMethod: PaymentMethod.values.firstWhere(
            (e) => e.key == json['paymentMethod'],
        orElse: () => PaymentMethod.cash,
      ),
      createdAt: (json['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "amount": amount,
      "category": category.key,
      "paymentMethod": paymentMethod.key,
      "createdAt": createdAt,
    };
  }
}