class UserModel {
  final String id;
  final String email;
  final String name;
  final String token;
  final String? refreshToken;

  UserModel({
    required this.id,
    required this.email,
    required this.name,
    required this.token,
    this.refreshToken,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: (json['id'] ?? '').toString(),
      email: (json['email'] ?? '').toString(),
      name: (json['name'] ?? '').toString(),
      token: (json['token'] ?? '').toString(),
      refreshToken: (json['refreshToken'] ?? '').toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'token': token,
      'refreshToken': refreshToken,
    };
  }
}
