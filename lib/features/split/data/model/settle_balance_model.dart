
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expenseo/features/split/domain/entity/settle_balance.dart';

class SettleBalanceModel {
  final String   id;
  final String   groupId;
  final String   from;
  final String   fromName;
  final String   to;
  final String   toName;
  final double   amount;
  final DateTime createdAt;

  const SettleBalanceModel({
    required this.id,
    required this.groupId,
    required this.from,
    required this.fromName,
    required this.to,
    required this.toName,
    required this.amount,
    required this.createdAt,
  });

  factory SettleBalanceModel.fromJson(String id, Map<String, dynamic> json) {
    return SettleBalanceModel(
      id: id,
      groupId: (json['groupId']  ?? '').toString(),
      from: (json['from']  ?? '').toString(),
      fromName: (json['fromName'] ?? '').toString(),
      to: (json['to'] ?? '').toString(),
      toName: (json['toName']  ?? '').toString(),
      amount: (json['amount'] as num).toDouble(),
      createdAt: (json['createdAt'] as Timestamp).toDate().toLocal(),
    );
  }

  Map<String, dynamic> toJson() => {
    'groupId': groupId,
    'from': from,
    'fromName': fromName,
    'to': to,
    'toName': toName,
    'amount': amount,
    'createdAt': Timestamp.fromDate(createdAt),
  };

  SettleBalance toEntity() => SettleBalance(
    id:        id,
    groupId:   groupId,
    from:      from,
    fromName:  fromName,
    to:        to,
    toName:    toName,
    amount:    amount,
    createdAt: createdAt,
  );

  factory SettleBalanceModel.fromEntity(SettleBalance entity) =>
      SettleBalanceModel(
        id:        entity.id,
        groupId:   entity.groupId,
        from:      entity.from,
        fromName:  entity.fromName,
        to:        entity.to,
        toName:    entity.toName,
        amount:    entity.amount,
        createdAt: entity.createdAt,
      );
}