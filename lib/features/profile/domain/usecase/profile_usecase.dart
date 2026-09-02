import 'dart:io';

import 'package:expenseo/features/profile/domain/repository/profile_repository.dart';

import '../../../auth/domain/entity/user.dart';

class ProfileUseCase {
  final ProfileRepository profileRepository;

  ProfileUseCase({required this.profileRepository});

  Future<User> completeProfile({
    required String userId,
    required String phoneNumber,
    required String gender,
    required String dob,
    File? profileImage,
  }) {
    return profileRepository.completeProfile(
      userId: userId,
      phoneNumber: phoneNumber,
      gender: gender,
      dob: dob,
      profileImage: profileImage,
    );
  }

  Future<User> getProfile(String userId) {
    return profileRepository.getProfile(userId);
  }
}
