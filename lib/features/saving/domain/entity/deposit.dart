class Deposit {
  final String id;
  final String goalId;
  final double amount;
  final DateTime createdAt;

  const Deposit({
    required this.id,
    required this.goalId,
    required this.amount,
    required this.createdAt,
  });
}
