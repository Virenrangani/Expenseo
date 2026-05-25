
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entity/saving_goal.dart';

class SavingGoalModel {
  final String id;
  final String goal;
  final double targetAmount;
  final double savedAmount;
  final bool isCompleted;
  final DateTime createdAt;

  const SavingGoalModel({
    required this.id,
    required this.goal,
    required this.targetAmount,
    required this.savedAmount,
    required this.isCompleted,
    required this.createdAt,
  });

  factory SavingGoalModel.fromJson(
      String id, Map<String, dynamic> json) {
    return SavingGoalModel(
      id: id,
      goal: json['goal']?.toString() ?? '',
      targetAmount: (json['targetAmount'] as num?)?.toDouble() ?? 0.0,
      savedAmount: (json['savedAmount'] as num?)?.toDouble() ?? 0.0,
      isCompleted: json['isCompleted'] as bool? ?? false,
      createdAt: (json['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() => {
    'goal': goal,
    'targetAmount': targetAmount,
    'savedAmount': savedAmount,
    'isCompleted': isCompleted,
    'createdAt':  Timestamp.fromDate(createdAt),
  };

  SavingGoal toEntity() => SavingGoal(
    id: id,
    goal: goal,
    targetAmount: targetAmount,
    savedAmount: savedAmount,
    isCompleted: isCompleted,
    createdAt: createdAt,
  );

  factory SavingGoalModel.fromEntity(SavingGoal entity) =>
      SavingGoalModel(
        id: entity.id,
        goal: entity.goal,
        targetAmount: entity.targetAmount,
        savedAmount: entity.savedAmount,
        isCompleted: entity.isCompleted,
        createdAt: entity.createdAt,
      );
}