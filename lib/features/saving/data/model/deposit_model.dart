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

  factory DepositModel.fromJson(Map<String, dynamic> json) {
    return DepositModel(
      id: (json['id'] ?? '').toString(),
      goalId: (json['savingGoalId'] ?? json['goalId'] ?? '').toString(),
      amount: (json['savedAmount'] as num?)?.toDouble() ??
          (json['amount'] as num?)?.toDouble() ?? 0.0,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'].toString()).toLocal()
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() => {
    'savingGoalId': goalId,
    'savedAmount': amount,
  };

  Deposit toEntity() => Deposit(
      id: id,
      goalId: goalId,
      amount: amount,
      createdAt: createdAt
  );

  factory DepositModel.fromEntity(Deposit entity) => DepositModel(
    id: entity.id,
    goalId: entity.goalId,
    amount: entity.amount,
    createdAt: entity.createdAt,
  );
}
