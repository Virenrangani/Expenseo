import '../../domain/entity/group_entity.dart';

class GroupModel {
  final String id;
  final String name;
  final String createdBy;
  final List<String> members;
  final Map<String, String> memberNames;
  final DateTime createdAt;

  const GroupModel({
    required this.id,
    required this.name,
    required this.createdBy,
    required this.members,
    required this.memberNames,
    required this.createdAt,
  });

  factory GroupModel.fromJson(Map<String, dynamic> json) {
    return GroupModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      createdBy: json['createdBy'] as String? ?? '',
      members: (json['members'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      memberNames: (json['memberNames'] as Map<String, dynamic>?)
              ?.map((key, value) => MapEntry(key, value as String)) ??
          {},
      createdAt: _parseDateTime(json['createdAt']),
    );
  }

  static DateTime _parseDateTime(dynamic date) {
    if (date == null) return DateTime.now();
    if (date is int) return DateTime.fromMillisecondsSinceEpoch(date);
    try {
      return DateTime.parse(date.toString());
    } catch (_) {
      return DateTime.now();
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'createdBy': createdBy,
      'members': members,
      'memberNames': memberNames,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  GroupEntity toEntity() {
    return GroupEntity(
      id: id,
      name: name,
      createdBy: createdBy,
      members: members,
      memberNames: memberNames,
      createdAt: createdAt,
    );
  }

  factory GroupModel.fromEntity(GroupEntity entity) {
    return GroupModel(
      id: entity.id,
      name: entity.name,
      createdBy: entity.createdBy,
      members: entity.members,
      memberNames: entity.memberNames,
      createdAt: entity.createdAt,
    );
  }
}
