import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entity/deposit.dart';

class DepositModel {
  final String id;
  final String goalId;
  final double amount;
  final DateTime createdAt;

  const DepositModel({
    required this.id,
    required this.goalId,
    required this.amount,
    required this.createdAt,
  });

  factory DepositModel.fromJson(String id, Map<String, dynamic> json) {
    return DepositModel(
      id: id,
      goalId: json['goalId'].toString(),
      amount: (json['amount'] as num).toDouble(),
      createdAt: (json['createdAt'] as Timestamp).toDate().toLocal(),
    );
  }

  Map<String, dynamic> toJson() => {
    'goalId': goalId,
    'amount': amount,
    'createdAt': Timestamp.fromDate(createdAt),
  };

  Deposit toEntity() =>
      Deposit(id: id, goalId: goalId, amount: amount, createdAt: createdAt);

  factory DepositModel.fromEntity(Deposit entity) => DepositModel(
    id: entity.id,
    goalId: entity.goalId,
    amount: entity.amount,
    createdAt: entity.createdAt,
  );
}
