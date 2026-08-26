class UserModel {
  final String id;
  final String email;
  final String name;
  final String token;
  final String? refreshToken;
  final String? profileImage;
  final String? phoneNumber;
  final String? gender;
  final String? dob;
  final bool isProfileComplete;

  UserModel({
    required this.id,
    required this.email,
    required this.name,
    required this.token,
    this.refreshToken,
    this.profileImage,
    this.phoneNumber,
    this.gender,
    this.dob,
    this.isProfileComplete = false,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: (json['id'] ?? '').toString(),
      email: (json['email'] ?? '').toString(),
      name: (json['name'] ?? '').toString(),
      token: (json['token'] ?? '').toString(),
      refreshToken: json['refreshToken']?.toString(),
      profileImage: json['profileImage']?.toString(),
      phoneNumber: json['phoneNumber']?.toString(),
      gender: json['gender']?.toString(),
      dob: json['dob']?.toString(),
      isProfileComplete: json['isProfileComplete'] == true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'token': token,
      'refreshToken': refreshToken,
      'profileImage': profileImage,
      'phoneNumber': phoneNumber,
      'gender': gender,
      'dob': dob,
      'isProfileComplete': isProfileComplete,
    };
  }
}
