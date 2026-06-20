import 'package:expenseo/features/split/domain/entity/user.dart';

class UserModel {
  final String uid;
  final String name;
  final String email;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
  });

  factory UserModel.fromFirestore(
      Map<String, dynamic> data,
      String docId,
      ) {
    return UserModel(
      uid: (data['uid'] ?? docId).toString(),
      name: (data['name'] ?? '').toString(),
      email: (data['email'] ?? '').toString(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
    };
  }

  User toEntity() {
    return User(uid:uid, name:name, email:email);
  }

  factory UserModel.fromEntity(User user) {
    return UserModel(uid: user.uid, name: user.name, email: user.email);
  }
}