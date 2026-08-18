class User {
  final String id;
  final String? name;
  final String email;
  final String? profileImage;
  final String? phoneNumber;
  final String? gender;
  final DateTime? dob;
  final bool isProfileComplete;

  User({
    required this.id,
    this.name,
    required this.email,
    this.profileImage,
    this.phoneNumber,
    this.gender,
    this.dob,
    this.isProfileComplete = false,
  });
}
