import 'dart:io';

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
    final userModel = await remoteDataSource.completeProfile(
      userId: userId,
      phoneNumber: phoneNumber,
      gender: gender,
      dob: dob,
      profileImageUrl: profileImage?.path,
    );

    return User(
      id: userModel.id,
      name: userModel.name,
      email: userModel.email,
      profileImage: userModel.profileImage,
      phoneNumber: userModel.phoneNumber,
      gender: userModel.gender,
      dob: userModel.dob != null ? DateTime.tryParse(userModel.dob!) : null,
      isProfileComplete: userModel.isProfileComplete,
    );
  }
}
