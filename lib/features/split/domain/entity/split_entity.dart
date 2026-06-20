
enum SplitType { equal, unequal, percentage }

class SplitEntity {
  final String  id;
  final String  groupId;
  final String  title;
  final double  amount;
  final String  paidBy;
  final String  paidByName;
  final Map<String, double> splitAmong;
  final SplitType splitType;
  final DateTime  createdAt;

  const SplitEntity({
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
}