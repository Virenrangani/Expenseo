class GroupResponseModel {
  final String id;
  final String name;
  final DateTime createdAt;

  const GroupResponseModel({
    required this.id,
    required this.name,
    required this.createdAt,
  });

  factory GroupResponseModel.fromJson(
      Map<String, dynamic> json) {
    return GroupResponseModel(
      id: json['id'].toString(),
      name: json['name'].toString(),
      createdAt: DateTime.parse(json['createdAt'].toString()),
    );
  }
}