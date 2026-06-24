
import 'package:cloud_firestore/cloud_firestore.dart';
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

  factory SavingModel.fromJson(
      String id, Map<String, dynamic> json) {
    return SavingModel(
      id: id,
      goal: json['goal']?.toString() ?? '',
      goalImage: json['goalImage']?.toString() ?? '',
      targetAmount: (json['targetAmount'] as num?)?.toDouble() ?? 0.0,
      savedAmount: (json['savedAmount'] as num?)?.toDouble() ?? 0.0,
      isCompleted: json['isCompleted'] as bool? ?? false,
      createdAt: (json['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() => {
    'goal': goal,
    'goalImage':goalImage,
    'targetAmount': targetAmount,
    'savedAmount': savedAmount,
    'isCompleted': isCompleted,
    'createdAt':  Timestamp.fromDate(createdAt),
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

  factory SavingModel.fromEntity(SavingGoal entity) =>
      SavingModel(
        id: entity.id,
        goal: entity.goal,
        goalImage: entity.goalImage,
        targetAmount: entity.targetAmount,
        savedAmount: entity.savedAmount,
        isCompleted: entity.isCompleted,
        createdAt: entity.createdAt,
      );
}