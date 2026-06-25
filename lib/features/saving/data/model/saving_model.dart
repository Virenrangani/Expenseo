import '../../domain/entity/saving_goal.dart';

class SavingModel {
  final String id;
  final String goal;
  final String goalImage;
  final double targetAmount;
  final double savedAmount;
  final bool isCompleted;
  final DateTime createdAt;

  const SavingModel({
    required this.id,
    required this.goal,
    required this.goalImage,
    required this.targetAmount,
    required this.savedAmount,
    required this.isCompleted,
    required this.createdAt,
  });

  factory SavingModel.fromJson(Map<String, dynamic> json) {
    return SavingModel(
      id: (json['id'] ?? '').toString(),
      goal: (json['goal'] ?? '').toString(),
      goalImage: (json['imageUrl'] ?? '').toString(),
      targetAmount: (json['targetAmount'] as num?)?.toDouble() ?? 0.0,
      savedAmount: (json['savingAmount'] as num?)?.toDouble() ?? 0.0,
      isCompleted: json['isCompleted'] as bool? ?? false,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'].toString()).toLocal()
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() => {
    'goal': goal,
    'imageUrl': goalImage,
    'targetAmount': targetAmount,
  };

  SavingGoal toEntity() => SavingGoal(
    id: id,
    goal: goal,
    goalImage: goalImage,
    targetAmount: targetAmount,
    savedAmount: savedAmount,
    isCompleted: isCompleted,
    createdAt: createdAt,
  );

  factory SavingModel.fromEntity(SavingGoal entity) => SavingModel(
    id: entity.id,
    goal: entity.goal,
    goalImage: entity.goalImage,
    targetAmount: entity.targetAmount,
    savedAmount: entity.savedAmount,
    isCompleted: entity.isCompleted,
    createdAt: entity.createdAt,
  );
}
