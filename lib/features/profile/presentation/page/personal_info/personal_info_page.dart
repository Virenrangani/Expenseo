import 'package:expenseo/core/widget/text_field/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../../../../core/constant/colour/app_color.dart';
import '../../../../../core/constant/gap/app_gap.dart';
import '../../../../../core/constant/padding/app_padding.dart';
import '../../../../../core/constant/text_style/app_text_style.dart';
import '../../../../../core/extension/localization_extension.dart';
import '../../../../../core/storage/shared_pref/shared_pref_service.dart';
import '../../../../../features/profile/domain/usecase/profile_usecase.dart';

class PersonalInfoPage extends StatefulWidget {
  const PersonalInfoPage({super.key});

  @override
  State<PersonalInfoPage> createState() => _PersonalInfoPageState();
}

class _PersonalInfoPageState extends State<PersonalInfoPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  String _selectedGender = 'Female';
  bool _isLoading = false;
  @override
  void initState() {
    super.initState();
    _loadProfile();
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
          'Personal Information',
          style: AppTextStyles.h4().copyWith(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: AppPadding.edgeAll16,
              child: Column(
                children: [
                  // Profile Picture Section
                  Center(
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 4),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withAlpha(10),
                                blurRadius: 10,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: const CircleAvatar(
                            radius: 60,
                            backgroundImage: NetworkImage(
                              'https://i.pravatar.cc/150?img=47',
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: const BoxDecoration(
                              color: AppColor.primary,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.camera_alt_rounded,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  AppGap.g32,

                  AppFormField(
                    controller: _nameController,
                    prefixIcon: const Icon(Icons.person_outline_rounded),
                    labelText: context.l10n.fullName,
                  ),
                  AppGap.g16,
                  AppFormField(
                    controller: _emailController,
                    prefixIcon: const Icon(Icons.email_outlined),
                    labelText: context.l10n.emailAddress,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  AppGap.g16,
                  AppFormField(
                    controller: _phoneController,
                    prefixIcon: const Icon(Icons.phone_outlined),
                    labelText: context.l10n.phoneNumber,
                    keyboardType: TextInputType.phone,
                  ),
                  AppGap.g16,
                  AppFormField(
                    controller: _dobController,
                    prefixIcon: const Icon(Icons.calendar_today_outlined),
                    labelText: context.l10n.dateOfBirth,
                    keyboardType: TextInputType.datetime,
                    suffix: const Icon(Icons.calendar_month),
                    onSuffixTap: () async {
                      final date = await showDatePicker(
                        context: context,
                        initialDate: DateTime(1995, 5, 12),
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now(),
                      );
                      if (date != null) {
                        setState(() {
                          _dobController.text =
                              '${date.day} ${_getMonthName(date.month)} ${date.year}';
                        });
                      }
                    },
                  ),
                  AppGap.g16,

                  _buildGenderDropdown(),

                  AppGap.g64,

                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _onSave,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.primary,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        context.l10n.saveChanges,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildGenderDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(
            context.l10n.gender,
            style: AppTextStyles.bodySmall().copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
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
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _selectedGender,
              isExpanded: true,
              icon: const Icon(
                Icons.keyboard_arrow_down_rounded,
                color: AppColor.textSecondary,
              ),
              items:
                  [
                    context.l10n.male,
                    context.l10n.female,
                    context.l10n.other,
                  ].map((value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Row(
                        children: [
                          const Icon(
                            Icons.wc_rounded,
                            color: AppColor.primary,
                            size: 22,
                          ),
                          AppGap.g12,
                          Text(
                            value,
                            style: AppTextStyles.bodyMedium(
                              color: AppColor.textPrimary,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
              onChanged: (newValue) {
                setState(() {
                  _selectedGender = newValue!;
                });
              },
            ),
          ),
        ),
      ],
    );
  }

  String _getMonthName(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return months[month - 1];
  }

  Future<void> _loadProfile() async {
    final userId = SharedPrefService.getUserId();
    if (userId == null || userId.isEmpty) return;

    setState(() => _isLoading = true);
    try {
      final usecase = GetIt.I<ProfileUseCase>();
      final user = await usecase.getProfile(userId);

      setState(() {
        _nameController.text = user.name ?? '';
        _emailController.text = user.email;
        _phoneController.text = user.phoneNumber ?? '';
        if (user.dob != null) {
          final dt = user.dob!;
          _dobController.text =
              '${dt.day} ${_getMonthName(dt.month)} ${dt.year}';
        }
        if (user.gender != null && user.gender!.isNotEmpty) {
          _selectedGender = user.gender!;
        }
      });
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _onSave() async {
    final userId = SharedPrefService.getUserId();
    if (userId == null || userId.isEmpty) return;

    setState(() => _isLoading = true);

    try {
      final usecase = GetIt.I<ProfileUseCase>();
      final user = await usecase.completeProfile(
        userId: userId,
        phoneNumber: _phoneController.text.trim(),
        gender: _selectedGender,
        dob: _dobController.text.trim(),
      );

      final name = user.name ?? _nameController.text;
      final email = user.email;
      await SharedPrefService.saveUser(
        id: userId,
        email: email,
        name: name,
        isProfileComplete: true,
      );
      await SharedPrefService.setProfileComplete(true);

      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Profile updated')));
      Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Failed to update profile')));
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }
}
