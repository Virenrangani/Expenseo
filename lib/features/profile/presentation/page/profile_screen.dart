import 'package:expenseo/core/constant/colour/app_color.dart';
import 'package:expenseo/core/constant/gap/app_gap.dart';
import 'package:expenseo/core/constant/text_style/app_text_style.dart';
import 'package:expenseo/core/localization/locale_cubit.dart';
import 'package:expenseo/core/storage/shared_pref/shared_pref_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/extension/localization_extension.dart';
import '../../../../core/navigation/app_navigation.dart';
import '../../../../core/widget/login_required_dialog/login_required_dialog.dart';
import '../../../auth/presentation/page/splash_screen.dart';
import '../widget/profile_tile.dart';
import 'personal_info/personal_info_page.dart';
import 'security/security_page.dart';
import '../../../../core/theme/logic/theme_cubit.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late final ScrollController _scrollController;
  bool _isCollapsed = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()
      ..addListener(() {
        if (_scrollController.hasClients) {
          if (_scrollController.offset > 200 && !_isCollapsed) {
            setState(() {
              _isCollapsed = true;
            });
          } else if (_scrollController.offset <= 200 && _isCollapsed) {
            setState(() {
              _isCollapsed = false;
            });
          }
        }
      });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _showLanguagePicker(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(context.l10n.selectLanguage, style: AppTextStyles.h4()),
            AppGap.g24,
            ListTile(
              title: Text(context.l10n.english),
              leading: const Text('🇺🇸', style: TextStyle(fontSize: 24)),
              onTap: () {
                context.read<LocaleCubit>().changeLocale('en');
                context.pop(context);
              },
            ),
            ListTile(
              title: Text(context.l10n.arabic),
              leading: const Text('🇸🇦', style: TextStyle(fontSize: 24)),
              onTap: () {
                context.read<LocaleCubit>().changeLocale('ar');
                context.pop(context);
              },
            ),
            ListTile(
              title: Text(context.l10n.hindi),
              leading: const Text('🇮🇳', style: TextStyle(fontSize: 24)),
              onTap: () {
                context.read<LocaleCubit>().changeLocale('hi');
                context.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isGuest = SharedPrefService.isGuest();
    final currentLocale = context.watch<LocaleCubit>().state.languageCode;

    String getLanguageName() {
      switch (currentLocale) {
        case 'en':
          return context.l10n.english;
        case 'ar':
          return context.l10n.arabic;
        case 'hi':
          return context.l10n.hindi;
        default:
          return context.l10n.english;
      }
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FB),
      body: CustomScrollView(
        controller: _scrollController,
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            stretch: true,
            backgroundColor: AppColor.primary,
            elevation: 0,
            actions: const [],
            iconTheme: const IconThemeData(color: Colors.white),
            title: AnimatedOpacity(
              duration: const Duration(milliseconds: 200),
              opacity: _isCollapsed ? 1.0 : 0.0,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(
                      'https://i.pravatar.cc/150?img=47',
                    ),
                  ),
                  AppGap.g8,
                  Text(
                    isGuest ? context.l10n.guestUser : 'Beatrice Cox',
                    style: AppTextStyles.h3(
                      color: Colors.white,
                    ).copyWith(fontSize: 18),
                  ),
                ],
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              stretchModes: const [
                StretchMode.zoomBackground,
                StretchMode.blurBackground,
              ],
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    'https://i.pravatar.cc/150?img=47',
                    fit: BoxFit.cover,
                  ),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withAlpha(150),
                        ],
                        stops: const [0.6, 1.0],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 20,
                    right: 20,
                    bottom: 20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          isGuest ? context.l10n.guestUser : 'Beatrice Cox',
                          style: AppTextStyles.h3(
                            color: Colors.white,
                          ).copyWith(fontSize: 28),
                        ),
                        Text(
                          isGuest ? context.l10n.guest : 'cox21@gmail.com',
                          style: AppTextStyles.description(
                            color: Colors.white.withAlpha(200),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle(context.l10n.accountSettings),
                  _buildGroupedCard([
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
                          context.push(const PersonalInfoPage());
                        }
                      },
                    ),
                  ]),

                  AppGap.g24,

                  _buildSectionTitle(context.l10n.preferences),
                  _buildGroupedCard([
                    SettingsTile(
                      title: context.l10n.language,
                      leadingIcon: Icons.language_rounded,
                      trailing: Text(
                        getLanguageName(),
                        style: AppTextStyles.bodySmall(),
                      ),
                      onTap: () => _showLanguagePicker(context),
                    ),
                    SettingsTile(
                      title: context.l10n.notifications,
                      leadingIcon: Icons.notifications_none_rounded,
                      onTap: () {},
                    ),
                    SettingsTile(
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
                      onTap: () {
                        showModalBottomSheet<void>(
                          context: context,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                          ),
                          builder: (_) => Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text('Choose Theme', style: AppTextStyles.h4()),
                                AppGap.g16,
                                RadioListTile<ThemeMode>(
                                  value: ThemeMode.system,
                                  groupValue: context.read<ThemeCubit>().state,
                                  title: const Text('System'),
                                  onChanged: (val) {
                                    if (val != null) {
                                      context.read<ThemeCubit>().setTheme(val);
                                      Navigator.of(context).pop();
                                    }
                                  },
                                ),
                                RadioListTile<ThemeMode>(
                                  value: ThemeMode.light,
                                  groupValue: context.read<ThemeCubit>().state,
                                  title: const Text('Light'),
                                  onChanged: (val) {
                                    if (val != null) {
                                      context.read<ThemeCubit>().setTheme(val);
                                      Navigator.of(context).pop();
                                    }
                                  },
                                ),
                                RadioListTile<ThemeMode>(
                                  value: ThemeMode.dark,
                                  groupValue: context.read<ThemeCubit>().state,
                                  title: const Text('Dark'),
                                  onChanged: (val) {
                                    if (val != null) {
                                      context.read<ThemeCubit>().setTheme(val);
                                      Navigator.of(context).pop();
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
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
                  ]),

                  AppGap.g24,

                  _buildSectionTitle(context.l10n.supportAndLegal),
                  _buildGroupedCard([
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
                  ]),

                  AppGap.g32,

                  _buildGroupedCard([
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
                  ]),

                  AppGap.g64,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
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

  Widget _buildGroupedCard(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(8),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: children.asMap().entries.map((entry) {
          final int idx = entry.key;
          final Widget child = entry.value;
          return Column(
            children: [
              child,
              if (idx != children.length - 1)
                const Divider(
                  height: 1,
                  indent: 60,
                  endIndent: 16,
                  color: Color(0xFFF1F1F1),
                ),
            ],
          );
        }).toList(),
      ),
    );
  }
}
