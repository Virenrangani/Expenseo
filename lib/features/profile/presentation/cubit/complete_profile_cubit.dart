import 'dart:io';

import 'package:expenseo/features/profile/domain/repository/profile_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'complete_profile_state.dart';

class CompleteProfileCubit extends Cubit<CompleteProfileState> {
  final ProfileRepository profileRepository;

  CompleteProfileCubit({required this.profileRepository})
    : super(const CompleteProfileState());

  Future<void> completeProfile({
    required String userId,
    required String phoneNumber,
    required String gender,
    required String dob,
    File? profileImage,
  }) async {
    emit(state.copyWith(status: CompleteProfileStatus.loading));

    try {
      final user = await profileRepository.completeProfile(
        userId: userId,
        phoneNumber: phoneNumber,
        gender: gender,
        dob: dob,
        profileImage: profileImage,
      );

      emit(state.copyWith(status: CompleteProfileStatus.success, user: user));
    } catch (e) {
      emit(
        state.copyWith(
          status: CompleteProfileStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
