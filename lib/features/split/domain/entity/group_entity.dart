class GroupEntity {
  final String id;
  final String name;
  final String createdBy;
  final List<String> members;
  final Map<String, String> memberNames;
  final DateTime createdAt;

  const GroupEntity({
    required this.id,
    required this.name,
    required this.createdBy,
    required this.members,
    required this.memberNames,
    required this.createdAt,
  });

  double yourBalance(String uid) {
    return 0;
  }
}