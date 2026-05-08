class SettleBalance {
  final String id;
  final String groupId;
  final String from;
  final String fromName;
  final String to;
  final String toName;
  final double amount;
  final DateTime createdAt;

  const SettleBalance({
    required this.id,
    required this.groupId,
    required this.from,
    required this.fromName,
    required this.to,
    required this.toName,
    required this.amount,
    required this.createdAt,
  });
}