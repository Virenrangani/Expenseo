import 'package:expenseo/features/profile/presentation/cubit/profile_view_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/repository/profile_repository.dart';

class ProfileViewCubit extends Cubit<ProfileViewState> {
  final ProfileRepository profileRepository;

  ProfileViewCubit({required this.profileRepository})
    : super(ProfileViewInitial());

  Future<void> fetchProfile(String userId) async {
    emit(ProfileViewLoading());
    try {
      final user = await profileRepository.getProfile(userId);
      emit(ProfileViewLoaded(user));
    } catch (e) {
      emit(ProfileViewError(e.toString().replaceAll('Exception: ', '')));
    }
  }
}
