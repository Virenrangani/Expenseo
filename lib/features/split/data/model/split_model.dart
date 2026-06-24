import '../../domain/entity/split_entity.dart';

class SplitModel {
  final String id;
  final String groupId;
  final String title;
  final double amount;
  final String paidByUserId;
  final String paidByName;
  final Map<String, double> splitAmong;
  final SplitType splitType;
  final DateTime createdAt;

  const SplitModel({
    required this.id,
    required this.groupId,
    required this.title,
    required this.amount,
    required this.paidByUserId,
    required this.paidByName,
    required this.splitAmong,
    required this.splitType,
    required this.createdAt,
  });

  factory SplitModel.fromJson(Map<String, dynamic> data) {
    final splitsList = data['splits'] as List<dynamic>? ?? [];
    final parsedSplitAmong = <String, double>{};
    for (final split in splitsList) {
      parsedSplitAmong[split['userId'].toString()] = (split['amountOwed'] as num).toDouble();
    }

    return SplitModel(
      id: (data['id'] ?? '').toString(),
      groupId: (data['groupId'] ?? '').toString(),
      title: (data['title'] ?? '').toString(),
      amount: (data['amount'] as num?)?.toDouble() ?? 0.0,
      paidByUserId: (data['paidByUserId'] ?? '').toString(),
      paidByName: (data['paidByUserName'] ?? 'Unknown').toString(),
      splitAmong: parsedSplitAmong,
      splitType: SplitType.values.firstWhere(
            (e) => e.name.toUpperCase() == (data['splitExpenseType'] ?? '').toString().toUpperCase(),
        orElse: () => SplitType.equal,
      ),
      createdAt: data['createdAt'] != null
          ? DateTime.parse(data['createdAt'].toString()).toLocal()
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    final List<Map<String, dynamic>> splitsList = splitAmong.entries.map((entry) {
      return {
        'userId': entry.key,
        'amountOwed': entry.value,
      };
    }).toList();

    return {
      'groupId': groupId,
      'title': title,
      'amount': amount,
      'paidByUserId': paidByUserId,
      'splitExpenseType': splitType.name.toUpperCase(),
      'splits': splitsList,
      'paidByUserName':paidByName
      // We do not send createdAt; Spring Boot generates it
    };
  }

  SplitEntity toEntity() {
    return SplitEntity(
      id: id,
      groupId: groupId,
      title: title,
      amount: amount,
      paidBy: paidByUserId,
      paidByName: paidByName,
      splitAmong: splitAmong,
      splitType: splitType,
      createdAt: createdAt,
    );
  }

  factory SplitModel.fromEntity(SplitEntity entity) {
    return SplitModel(
      id: entity.id,
      groupId: entity.groupId,
      title: entity.title,
      amount: entity.amount,
      paidByUserId: entity.paidBy,
      paidByName: entity.paidByName,
      splitAmong: entity.splitAmong,
      splitType: entity.splitType,
      createdAt: entity.createdAt,
    );
  }
}
