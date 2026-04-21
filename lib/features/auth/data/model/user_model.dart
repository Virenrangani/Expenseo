
import '../../domain/entity/user.dart';

class UserModel {
  final String id;
  final String email;
  final String name;

  UserModel({
    required this.id,
    required this.email,
    required this.name
  });

  factory UserModel.fromJson(User user){
    return UserModel(
        id: user.id,
        email: user.email,
        name: user.name??""
    );
  }

  Map<String , dynamic> toJson() {
    return {
      'id': id,
      "email": email,
      "name": name
    };
  }
}