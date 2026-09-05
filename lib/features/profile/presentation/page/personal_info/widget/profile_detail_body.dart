import 'package:expenseo/features/profile/presentation/page/personal_info/widget/profile_avatar_header.dart';
import 'package:flutter/cupertino.dart';

import '../../../../../../core/constant/gap/app_gap.dart';
import '../../../../../../core/constant/padding/app_padding.dart';
import '../../../../../../core/widget/elevated_button/app_elevated_button.dart';
import '../../../../../auth/domain/entity/user.dart';

class ProfileDetailBody extends StatelessWidget {
  final User user;
  final bool isCompleted;
  final VoidCallback onCompleteTap;

  const ProfileDetailBody({
    super.key,
    required this.user,
    required this.isCompleted,
    required this.onCompleteTap,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: AppPadding.edgeAll20,
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          ProfileAvatarHeader(user: user),
          AppGap.g24,
          if (!isCompleted) ...[const ProfileIncompleteBanner(), AppGap.g16],
          ProfileInfoCard(user: user, isCompleted: isCompleted),
          AppGap.g32,
          if (!isCompleted)
            AppElevatedButton(
              text: 'Complete Profile Now',
              isEnabled: true,
              onPressed: onCompleteTap,
            ),
        ],
      ),
    );
  }
}
