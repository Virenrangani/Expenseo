import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../../core/constant/colour/app_color.dart';
import '../../../../../../core/constant/gap/app_gap.dart';
import '../../../../../../core/constant/text_style/app_text_style.dart';
import '../../../../../auth/domain/entity/user.dart';

class ProfileAvatarHeader extends StatelessWidget {
  final User user;

  const ProfileAvatarHeader({super.key, required this.user});

  ImageProvider? _resolveImage(String? image) {
    if (image == null || image.isEmpty) return null;
    if (image.startsWith('data:')) {
      try {
        final base64Str = image.split(',').last;
        return MemoryImage(base64Decode(base64Str));
      } catch (_) {
        return null;
      }
    }
    return NetworkImage(image);
  }

  @override
  Widget build(BuildContext context) {
    final avatarImage = _resolveImage(user.profileImage);
    final displayName = (user.name?.trim().isNotEmpty ?? false)
        ? user.name!
        : '-';

    return Center(
      child: Column(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundColor: AppColor.primary.withAlpha(25),
            backgroundImage: avatarImage,
            child: avatarImage == null
                ? const Icon(Icons.person, size: 55, color: Colors.grey)
                : null,
          ),
          AppGap.g12,
          Text(
            displayName,
            style: AppTextStyles.h4().copyWith(fontWeight: FontWeight.bold),
          ),
          AppGap.g4,
          Text(user.email, style: AppTextStyles.bodyMedium()),
        ],
      ),
    );
  }
}

class ProfileIncompleteBanner extends StatelessWidget {
  const ProfileIncompleteBanner({super.key});

  @override
  Widget build(BuildContext context) {
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
}

class ProfileDetailRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color? valueColor;

  const ProfileDetailRow({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
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
}

class ProfileInfoCard extends StatelessWidget {
  final User user;
  final bool isCompleted;

  const ProfileInfoCard({
    super.key,
    required this.user,
    required this.isCompleted,
  });

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
          ProfileDetailRow(
            icon: Icons.phone_outlined,
            label: 'Phone Number',
            value: _fallback(user.phoneNumber),
          ),
          const Divider(
            height: 1,
            thickness: 1,
            indent: 52,
            endIndent: 16,
            color: Color(0xFFF1F1F1),
          ),
          ProfileDetailRow(
            icon: Icons.cake_outlined,
            label: 'Date of Birth',
            value: _formatDob(user.dob),
          ),
          const Divider(
            height: 1,
            thickness: 1,
            indent: 52,
            endIndent: 16,
            color: Color(0xFFF1F1F1),
          ),
          ProfileDetailRow(
            icon: Icons.wc_outlined,
            label: 'Gender',
            value: _fallback(user.gender),
          ),
          const Divider(
            height: 1,
            thickness: 1,
            indent: 52,
            endIndent: 16,
            color: Color(0xFFF1F1F1),
          ),
          ProfileDetailRow(
            icon: Icons.verified_user_outlined,
            label: 'Status',
            value: isCompleted ? 'Complete' : 'Incomplete',
            valueColor: isCompleted ? Colors.green : Colors.orange,
          ),
        ],
      ),
    );
  }
}
