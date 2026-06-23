import 'package:expenseo/features/split/data/model/user_model.dart';

class GroupResponseModel {
  final String id;
  final String name;
  final DateTime createdAt;
  final List<UserModel> members;

  const GroupResponseModel({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.members,
  });

  factory GroupResponseModel.fromJson(Map<String, dynamic> json) {
    return GroupResponseModel(
      id: json['id'].toString(),
      name: json['name'].toString(),
      createdAt: DateTime.parse(json['createdAt'].toString()),
      members:
          (json['members'] as List<dynamic>?)
              ?.map((e) => UserModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}
