import 'package:expenseo/features/split/domain/entity/user.dart';

class UserModel {
  final String uid;
  final String name;
  final String email;

  const UserModel({
    required this.uid,
    required this.name,
    required this.email,
  });

  factory UserModel.fromJson(Map<String, dynamic> data) {
    return UserModel(
      uid: (data['id'] ?? data['uid'] ?? '').toString(),
      name: (data['name'] ?? '').toString(),
      email: (data['email'] ?? '').toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': uid,
      'name': name,
      'email': email,
    };
  }

  User toEntity() {
    return User(
      uid: uid,
      name: name,
      email: email,
    );
  }

  factory UserModel.fromEntity(User user) {
    return UserModel(
      uid: user.uid,
      name: user.name,
      email: user.email,
    );
  }
}