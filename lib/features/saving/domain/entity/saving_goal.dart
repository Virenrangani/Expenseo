class SavingGoal {
  final String id;
  final String goal;
  final double targetAmount;
  final double savedAmount;
  final bool isCompleted;
  final DateTime createdAt;

  SavingGoal({
    required this.id,
    required this.goal,
    required this.targetAmount,
    required this.savedAmount,
    required this.isCompleted,
    required this.createdAt
  });
}