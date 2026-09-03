import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

import '../../../../../core/constant/colour/app_color.dart';
import '../../../../../core/constant/gap/app_gap.dart';
import '../../../../../core/constant/padding/app_padding.dart';
import '../../../../../core/constant/text_style/app_text_style.dart';
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
  // No need to pass userId anymore
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

  String _formatDob(DateTime? dob) {
    if (dob == null) return '-';
    return DateFormat('dd MMM yyyy').format(dob);
  }

  String _fallback(String? value) {
    if (value == null || value.trim().isEmpty) return '-';
    return value;
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
                    return _buildContent(context, state.user);
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

  Widget _buildContent(BuildContext context, User user) {
    final bool isCompleted = user.isProfileComplete;

    return SingleChildScrollView(
      padding: AppPadding.edgeAll20,
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          _buildAvatarHeader(user),
          AppGap.g24,
          if (!isCompleted) _buildIncompleteBanner(context),
          AppGap.g16,
          _buildInfoSection(user),
          AppGap.g32,
          AppElevatedButton(
            text: isCompleted ? 'Update Profile' : 'Complete Profile Now',
            isEnabled: true,
            onPressed: () async {
              await context.push(CompleteProfilePage(userId: _userId!));
              // Refresh details after editing
              if (mounted && _userId != null) {
                await _cubit.fetchProfile(_userId!);
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAvatarHeader(User user) {
    final hasImage = user.profileImage != null && user.profileImage!.isNotEmpty;

    return Center(
      child: Column(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundColor: AppColor.primary.withAlpha(25),
            backgroundImage: hasImage ? NetworkImage(user.profileImage!) : null,
            child: !hasImage
                ? const Icon(Icons.person, size: 55, color: Colors.grey)
                : null,
          ),
          AppGap.g12,
          Text(
            _fallback(user.name),
            style: AppTextStyles.h4().copyWith(fontWeight: FontWeight.bold),
          ),
          AppGap.g4,
          Text(user.email, style: AppTextStyles.bodyMedium()),
        ],
      ),
    );
  }

  Widget _buildIncompleteBanner(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.amber.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.amber.shade300),
      ),
      child: Row(
        children: [
          Icon(Icons.info_outline_rounded, color: Colors.amber.shade800),
          AppGap.g12,
          Expanded(
            child: Text(
              'Your profile is incomplete. Add your details for a personalized experience.',
              style: AppTextStyles.bodySmall().copyWith(
                color: Colors.amber.shade900,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoSection(User user) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(5),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildDetailRow(
            icon: Icons.phone_outlined,
            label: 'Phone Number',
            value: _fallback(user.phoneNumber),
          ),
          _buildDivider(),
          _buildDetailRow(
            icon: Icons.cake_outlined,
            label: 'Date of Birth',
            value: _formatDob(user.dob),
          ),
          _buildDivider(),
          _buildDetailRow(
            icon: Icons.wc_outlined,
            label: 'Gender',
            value: _fallback(user.gender),
          ),
          _buildDivider(),
          _buildDetailRow(
            icon: Icons.verified_user_outlined,
            label: 'Status',
            value: user.isProfileComplete ? 'Complete' : 'Incomplete',
            valueColor: user.isProfileComplete ? Colors.green : Colors.orange,
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow({
    required IconData icon,
    required String label,
    required String value,
    Color? valueColor,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Icon(icon, size: 22, color: AppColor.textSecondary),
          AppGap.g16,
          Expanded(child: Text(label, style: AppTextStyles.bodyMedium())),
          Text(
            value,
            style: AppTextStyles.bodyMedium().copyWith(
              fontWeight: FontWeight.w600,
              color: valueColor ?? AppColor.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return const Divider(
      height: 1,
      thickness: 1,
      indent: 52,
      endIndent: 16,
      color: Color(0xFFF1F1F1),
    );
  }
}
