import 'package:expenseo/core/constant/colour/app_color.dart';
import 'package:expenseo/core/constant/gap/app_gap.dart';
import 'package:expenseo/core/constant/text_style/app_text_style.dart';
import 'package:expenseo/core/enums/app_language.dart';
import 'package:expenseo/core/extension/app_language_extension.dart';
import 'package:expenseo/core/extension/localization_extension.dart';
import 'package:expenseo/core/localization/locale_cubit.dart';
import 'package:expenseo/core/storage/shared_pref/shared_pref_service.dart';
import 'package:expenseo/core/theme/logic/theme_cubit.dart';
import 'package:expenseo/core/utils/app_language_picker.dart';
import 'package:expenseo/core/widget/login_required_dialog/login_required_dialog.dart';
import 'package:expenseo/features/auth/presentation/page/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/navigation/app_navigation.dart';
import '../widget/profile_group_card.dart';
import '../widget/profile_header_sliver.dart';
import '../widget/profile_tile.dart';
import 'personal_info/personal_info_page.dart';
import 'security/security_page.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isGuest = SharedPrefService.isGuest();
    final currentLocale = context.watch<LocaleCubit>().state.languageCode;
    final isCollapsedNotifier = ValueNotifier<bool>(false);

    final displayName = isGuest
        ? context.l10n.guestUser
        : (SharedPrefService.getUserName() ?? '');
    final displayEmail = isGuest
        ? context.l10n.guest
        : (SharedPrefService.getUserEmail() ?? '');
    final storedImage = SharedPrefService.getUserProfileImage();

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FB),
      body: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          if (notification.metrics.axis == Axis.vertical) {
            final isNowCollapsed = notification.metrics.pixels > 200;
            if (isCollapsedNotifier.value != isNowCollapsed) {
              isCollapsedNotifier.value = isNowCollapsed;
            }
          }
          return false;
        },
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            ProfileHeaderSliver(
              displayName: displayName,
              displayEmail: displayEmail,
              profileImage: storedImage,
              isGuest: isGuest,
              isCollapsedNotifier: isCollapsedNotifier,
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionHeader(context.l10n.accountSettings),
                    ProfileGroupCard(
                      children: [
                        SettingsTile(
                          title: context.l10n.personalInfo,
                          leadingIcon: Icons.person_outline_rounded,
                          onTap: () {
                            if (isGuest) {
                              LoginRequiredDialog.show(
                                context,
                                context.l10n.personalInfo,
                              );
                            } else {
                              context.push(const UserProfileDetailPage());
                            }
                          },
                        ),
                      ],
                    ),
                    AppGap.g24,
                    _buildSectionHeader(context.l10n.preferences),
                    ProfileGroupCard(
                      children: [
                        SettingsTile(
                          title: context.l10n.language,
                          leadingIcon: Icons.language_rounded,
                          trailing: Text(
                            AppLanguage.fromCode(
                              currentLocale,
                            ).getName(context),
                            style: AppTextStyles.bodySmall(),
                          ),
                          onTap: () => appLanguagePicker(context),
                        ),
                        SettingsTile(
                          title: context.l10n.notifications,
                          leadingIcon: Icons.notifications_none_rounded,
                          onTap: () {},
                        ),
                        _buildThemeTile(context),
                        SettingsTile(
                          title: context.l10n.security,
                          leadingIcon: Icons.lock_outline_rounded,
                          onTap: () {
                            if (isGuest) {
                              LoginRequiredDialog.show(
                                context,
                                context.l10n.security,
                              );
                            } else {
                              context.push(const SecurityPage());
                            }
                          },
                        ),
                      ],
                    ),
                    AppGap.g24,
                    _buildSectionHeader(context.l10n.supportAndLegal),
                    ProfileGroupCard(
                      children: [
                        SettingsTile(
                          title: context.l10n.helpCenter,
                          leadingIcon: Icons.help_outline_rounded,
                          onTap: () {},
                        ),
                        SettingsTile(
                          title: context.l10n.privacyPolicy,
                          leadingIcon: Icons.description_outlined,
                          onTap: () {},
                        ),
                      ],
                    ),
                    AppGap.g32,
                    ProfileGroupCard(
                      children: [
                        SettingsTile(
                          title: isGuest
                              ? context.l10n.signInNow
                              : context.l10n.logout,
                          leadingIcon: isGuest
                              ? Icons.login_rounded
                              : Icons.logout_rounded,
                          isDestructive: !isGuest,
                          onTap: () async {
                            await SharedPrefService.clearUser();
                            if (!context.mounted) return;
                            await context.pushAndRemoveAll(const AuthGate());
                          },
                        ),
                      ],
                    ),
                    AppGap.g64,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, right: 4, bottom: 8),
      child: Text(
        title.toUpperCase(),
        style: AppTextStyles.descriptionSmall().copyWith(
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
          color: AppColor.textSecondary,
        ),
      ),
    );
  }

  Widget _buildThemeTile(BuildContext context) {
    return SettingsTile(
      title: 'Theme',
      leadingIcon: Icons.color_lens_outlined,
      trailing: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, mode) {
          final label = mode == ThemeMode.dark
              ? 'Dark'
              : (mode == ThemeMode.light ? 'Light' : 'System');
          return Text(label, style: AppTextStyles.bodySmall());
        },
      ),
      onTap: () => _showThemeBottomSheet(context),
    );
  }

  void _showThemeBottomSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Choose Theme', style: AppTextStyles.h4()),
            AppGap.g16,
            RadioGroup<ThemeMode>(
              groupValue: context.read<ThemeCubit>().state,
              onChanged: (val) {
                if (val != null) {
                  context.read<ThemeCubit>().setTheme(val);
                  Navigator.of(context).pop();
                }
              },
              child: const Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  RadioListTile<ThemeMode>(
                    value: ThemeMode.system,
                    title: Text('System'),
                  ),
                  RadioListTile<ThemeMode>(
                    value: ThemeMode.light,
                    title: Text('Light'),
                  ),
                  RadioListTile<ThemeMode>(
                    value: ThemeMode.dark,
                    title: Text('Dark'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
