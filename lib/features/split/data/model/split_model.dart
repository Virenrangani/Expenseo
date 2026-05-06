import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entity/split_entity.dart';

class SplitModel {
  final String id;
  final String groupId;
  final String title;
  final double amount;
  final String paidBy;
  final String paidByName;
  final Map<String, double> splitAmong;
  final SplitType splitType;
  final DateTime createdAt;

  const SplitModel({
    required this.id,
    required this.groupId,
    required this.title,
    required this.amount,
    required this.paidBy,
    required this.paidByName,
    required this.splitAmong,
    required this.splitType,
    required this.createdAt,
  });

  factory SplitModel.fromJson(Map<String, dynamic> data, String id) {
    return SplitModel(
      id: id,
      groupId: (data['groupId'] ?? '').toString(),
      title: (data['title'] ?? '').toString(),
      amount: (data['amount'] as num?)?.toDouble() ?? 0.0,
      paidBy: (data['paidBy'] ?? '').toString(),
      paidByName: (data['paidByName'] ?? '').toString(),
      splitAmong: Map<String, double>.from(
        (data['splitAmong'] as Map<String, dynamic>? ?? {}).map(
              (k, v) => MapEntry(k, (v as num).toDouble()),
        ),
      ),
      splitType: SplitType.values.firstWhere(
            (e) => e.name == data['splitType'],
        orElse: () => SplitType.equal,
      ),
      createdAt: DateTime.parse(data['createdAt'].toString()),
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'groupId': groupId,
      'title': title,
      'amount': amount,
      'paidBy': paidBy,
      'paidByName': paidByName,
      'splitAmong': splitAmong,
      'splitType': splitType.name,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }


  SplitEntity toEntity() {
    return SplitEntity(
      id: id,
      groupId: groupId,
      title: title,
      amount: amount,
      paidBy: paidBy,
      paidByName: paidByName,
      splitAmong: splitAmong,
      splitType: splitType,
      createdAt: createdAt,
    );
  }

  /// 🔹 Convert Entity → Model
  factory SplitModel.fromEntity(SplitEntity entity) {
    return SplitModel(
      id: entity.id,
      groupId: entity.groupId,
      title: entity.title,
      amount: entity.amount,
      paidBy: entity.paidBy,
      paidByName: entity.paidByName,
      splitAmong: entity.splitAmong,
      splitType: entity.splitType,
      createdAt: entity.createdAt,
    );
  }
}