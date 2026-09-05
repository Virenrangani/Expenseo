import 'dart:io';

import '../../../../core/utils/image_base64.dart';
import '../../../../core/storage/shared_pref/shared_pref_service.dart';
import '../../../auth/domain/entity/user.dart';
import '../../domain/repository/profile_repository.dart';
import '../data_source/profile_remote_data_source.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource remoteDataSource;

  ProfileRepositoryImpl(this.remoteDataSource);

  @override
  Future<User> completeProfile({
    required String userId,
    required String phoneNumber,
    required String gender,
    required String dob,
    File? profileImage,
  }) async {
    String? profileImageBase64;
    if (profileImage != null) {
      profileImageBase64 = await fileToBase64DataUrl(profileImage);
    }

    final userModel = await remoteDataSource.completeProfile(
      userId: userId,
      phoneNumber: phoneNumber,
      gender: gender,
      dob: dob,
      profileImageUrl: profileImageBase64,
    );

    final user = User(
      id: userModel.id,
      name: userModel.name,
      email: userModel.email,
      profileImage: userModel.profileImage,
      phoneNumber: userModel.phoneNumber,
      gender: userModel.gender,
      dob: userModel.dob != null ? DateTime.tryParse(userModel.dob!) : null,
      isProfileComplete: userModel.isProfileComplete,
    );

    // Persist key profile data locally so UI can show them without extra API calls.
    await SharedPrefService.setProfileComplete(user.isProfileComplete);
    await SharedPrefService.saveProfileImage(user.profileImage);

    return user;
  }

  @override
  Future<User> getProfile(String userId) async {
    final userModel = await remoteDataSource.getProfile(userId);

    final user = User(
      id: userModel.id,
      name: userModel.name,
      email: userModel.email,
      profileImage: userModel.profileImage,
      phoneNumber: userModel.phoneNumber,
      gender: userModel.gender,
      dob: userModel.dob != null ? DateTime.tryParse(userModel.dob!) : null,
      isProfileComplete: userModel.isProfileComplete,
    );

    await SharedPrefService.setProfileComplete(user.isProfileComplete);
    await SharedPrefService.saveProfileImage(user.profileImage);

    return user;
  }
}
