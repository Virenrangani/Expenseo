import 'package:expenseo/features/profile/presentation/page/personal_info/widget/profile_detail_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../../../core/constant/colour/app_color.dart';
import '../../../../../core/extension/snackbar_extension.dart';
import '../../../../../core/navigation/app_navigation.dart';
import '../../../../../core/storage/shared_pref/shared_pref_service.dart';
import '../../../../../core/widget/app_app_bar.dart';
import '../../../../../core/widget/elevated_button/app_elevated_button.dart';
import '../../../../auth/domain/entity/user.dart';
import '../../cubit/profile_view_cubit.dart';
import '../../cubit/profile_view_state.dart';
import '../complete_profile_page.dart';

class UserProfileDetailPage extends StatefulWidget {
  const UserProfileDetailPage({super.key});

  @override
  State<UserProfileDetailPage> createState() => _UserProfileDetailPageState();
}

class _UserProfileDetailPageState extends State<UserProfileDetailPage> {
  late final ProfileViewCubit _cubit;
  String? _userId;

  @override
  void initState() {
    super.initState();
    _cubit = GetIt.I<ProfileViewCubit>();
    _userId = SharedPrefService.getUserId();

    if (_userId != null && _userId!.isNotEmpty) {
      _cubit.fetchProfile(_userId!);
    }
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  bool _hasRequiredProfileFields(User user) {
    final hasPhone =
        user.phoneNumber != null && user.phoneNumber!.trim().isNotEmpty;
    final hasGender = user.gender != null && user.gender!.trim().isNotEmpty;
    final hasDob = user.dob != null;
    return hasPhone && hasGender && hasDob;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: Scaffold(
        backgroundColor: AppColor.background,
        appBar: const AppAppBar(
          title: 'Profile Details',
          backgroundColor: AppColor.primary,
        ),
        body: _userId == null
            ? const Center(child: Text('User session not found'))
            : BlocConsumer<ProfileViewCubit, ProfileViewState>(
                listener: (context, state) {
                  if (state is ProfileViewError) {
                    context.showErrorSnackBar(state.message);
                  }
                },
                builder: (context, state) {
                  if (state is ProfileViewLoading ||
                      state is ProfileViewInitial) {
                    return const Center(
                      child: CircularProgressIndicator(color: AppColor.primary),
                    );
                  }

                  if (state is ProfileViewLoaded) {
                    return ProfileDetailBody(
                      user: state.user,
                      isCompleted:
                          state.user.isProfileComplete ||
                          _hasRequiredProfileFields(state.user),
                      onCompleteTap: () async {
                        await context.push(
                          CompleteProfilePage(userId: _userId!),
                        );
                        if (mounted && _userId != null) {
                          await _cubit.fetchProfile(_userId!);
                        }
                      },
                    );
                  }

                  return Center(
                    child: AppElevatedButton(
                      text: 'Retry',
                      isEnabled: true,
                      onPressed: () => _cubit.fetchProfile(_userId!),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
