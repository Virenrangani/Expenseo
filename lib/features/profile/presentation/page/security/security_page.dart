import 'package:flutter/material.dart';

import '../../../../../core/constant/colour/app_color.dart';
import '../../../../../core/constant/gap/app_gap.dart';
import '../../../../../core/constant/text_style/app_text_style.dart';
import '../../widget/profile_tile.dart';

class SecurityPage extends StatefulWidget {
  const SecurityPage({super.key});

  @override
  State<SecurityPage> createState() => _SecurityPageState();
}

class _SecurityPageState extends State<SecurityPage> {
  bool _isAppLockEnabled = true;
  bool _isBiometricEnabled = false;
  bool _is2FAEnabled = false;

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
                onTap: () {},
                trailing: Switch.adaptive(
                  value: _isAppLockEnabled,
                  onChanged: (val) => setState(() => _isAppLockEnabled = val),
                ),
              ),
              SettingsTile(
                title: 'Biometric Authentication',
                leadingIcon: Icons.fingerprint_rounded,
                onTap: () {},
                trailing: Switch.adaptive(
                  value: _isBiometricEnabled,
                  onChanged: (val) => setState(() => _isBiometricEnabled = val),
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
                trailing: Switch.adaptive(
                  value: _is2FAEnabled,
                  onChanged: (val) => setState(() => _is2FAEnabled = val),
                ),
              ),
            ]),

            AppGap.g24,

            _buildSectionTitle('Devices'),
            _buildGroupedCard([
              SettingsTile(
                title: 'Active Sessions',
                leadingIcon: Icons.devices_rounded,
                onTap: () {},
                trailing: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: AppColor.success.withAlpha(30),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    '2 Active',
                    style: TextStyle(
                      color: AppColor.success,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ]),

            AppGap.g32,

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                'Protecting your financial data is our top priority. We recommend enabling Biometric Authentication and 2FA for maximum security.',
                style: AppTextStyles.descriptionSmall(),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
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
