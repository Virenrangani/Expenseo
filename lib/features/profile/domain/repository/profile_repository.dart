import 'dart:io';

import '../../../auth/domain/entity/user.dart';

abstract class ProfileRepository {
  Future<User> completeProfile({
    required String userId,
    required String phoneNumber,
    required String gender,
    required String dob,
    File? profileImage,
  });

  Future<User> getProfile(String userId);
}
