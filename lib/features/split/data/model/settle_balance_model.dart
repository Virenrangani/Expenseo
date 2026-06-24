import 'package:expenseo/features/split/domain/entity/settle_balance.dart';

class SettleBalanceModel {
  final String groupId;
  final String payerId;
  final String receiverId;
  final double amount;

  const SettleBalanceModel({
    required this.groupId,
    required this.payerId,
    required this.receiverId,
    required this.amount,
  });

  Map<String, dynamic> toJson() => {
    'groupId': groupId,
    'payerId': payerId,
    'receiverId': receiverId,
    'amount': amount,
  };

  factory SettleBalanceModel.fromEntity(SettleBalance entity) =>
      SettleBalanceModel(
        groupId:   entity.groupId,
        payerId:   entity.from,
        receiverId: entity.to,
        amount:    entity.amount,
      );
}
