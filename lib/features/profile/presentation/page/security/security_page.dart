import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../../../core/constant/colour/app_color.dart';
import '../../../../../core/constant/gap/app_gap.dart';
import '../../../../../core/constant/text_style/app_text_style.dart';
import '../../../../../core/security/logic/security_cubit.dart';
import '../../../../../core/security/service/security_service.dart';
import '../../../../auth/presentation/page/pin_lock/pin_lock_page.dart';
import '../../widget/profile_tile.dart';

class SecurityPage extends StatefulWidget {
  const SecurityPage({super.key});

  @override
  State<SecurityPage> createState() => _SecurityPageState();
}

class _SecurityPageState extends State<SecurityPage> {
  bool _isBiometricAvailable = false;
  bool _isBiometricEnabled = false;
  bool _isAppLockEnabled = false;

  @override
  void initState() {
    super.initState();
    _loadSecuritySettings();
  }

  Future<void> _loadSecuritySettings() async {
    final securityService = GetIt.I<SecurityService>();
    final isAvailable = await securityService.isBiometricAvailable();
    final isEnabled = await securityService.isBiometricEnabled();
    final hasPin = await securityService.hasPin();

    setState(() {
      _isBiometricAvailable = isAvailable;
      _isBiometricEnabled = isEnabled;
      _isAppLockEnabled = hasPin;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FB),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: AppColor.textPrimary,
            size: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Security',
          style: AppTextStyles.h4().copyWith(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Access Control'),
            _buildGroupedCard([
              SettingsTile(
                title: 'App Lock (PIN)',
                leadingIcon: Icons.dialpad_rounded,
                onTap: () async {
                  await context.read<SecurityCubit>().disableSecurity();
                  await _loadSecuritySettings();
                  if (mounted) {
                    Navigator.pop(context);
                  }
                },
                trailing: Switch.adaptive(
                  value: _isAppLockEnabled,
                  onChanged: (val) async {
                    if (val) {
                      await Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (context) =>
                              const PinLockPage(isSetupMode: true),
                        ),
                      );
                      await _loadSecuritySettings();
                    } else {
                      _showDisablePinDialog();
                    }
                  },
                ),
              ),
              if (_isBiometricAvailable)
                SettingsTile(
                  title: 'Biometric Authentication',
                  leadingIcon: Icons.fingerprint_rounded,
                  onTap: () {},
                  trailing: Switch.adaptive(
                    value: _isBiometricEnabled,
                    onChanged: (val) async {
                      await context.read<SecurityCubit>().toggleBiometric(val);
                      setState(() => _isBiometricEnabled = val);
                    },
                  ),
                ),
            ]),

            AppGap.g24,

            _buildSectionTitle('Account Security'),
            _buildGroupedCard([
              SettingsTile(
                title: 'Change Password',
                leadingIcon: Icons.password_rounded,
                onTap: () {},
              ),
              SettingsTile(
                title: 'Two-Factor Authentication',
                leadingIcon: Icons.verified_user_outlined,
                onTap: () {},
                trailing: Switch.adaptive(value: false, onChanged: (val) {}),
              ),
            ]),

            AppGap.g32,

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                'Protecting your financial data is our top priority. We recommend enabling Biometric Authentication for maximum security.',
                style: AppTextStyles.descriptionSmall(),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDisablePinDialog() {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.disable_app_lock),
        content: const Text(
          'Are you sure you want to remove the security PIN?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(AppLocalizations.of(context)!.cancel),
          ),
          TextButton(
            onPressed: () async {
              await GetIt.I<SecurityService>().clearSecurityData();
              await _loadSecuritySettings();
              if (mounted) {
                Navigator.pop(context);
              }
            },
            child: const Text(
              'Disable',
              style: TextStyle(color: AppColor.error),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 8),
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
