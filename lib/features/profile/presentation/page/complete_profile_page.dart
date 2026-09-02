import 'dart:io';

import 'package:expenseo/core/constant/colour/app_color.dart';
import 'package:expenseo/core/constant/gap/app_gap.dart';
import 'package:expenseo/core/storage/shared_pref/shared_pref_service.dart';
import 'package:expenseo/core/widget/app_app_bar.dart';
import 'package:expenseo/core/widget/elevated_button/app_elevated_button.dart';
import 'package:expenseo/core/widget/text_field/app_text_field.dart';
import 'package:expenseo/features/bottom_nav/app_bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

import '../../../../core/extension/localization_extension.dart';
import '../../../../core/extension/snackbar_extension.dart';
import '../../../../core/navigation/app_navigation.dart';
import '../../../../core/widget/image_source_picker/image_source_picker.dart';
import '../cubit/complete_profile_cubit.dart';
import '../cubit/complete_profile_state.dart';

class CompleteProfilePage extends StatefulWidget {
  final String userId;

  const CompleteProfilePage({super.key, required this.userId});

  @override
  State<CompleteProfilePage> createState() => _CompleteProfilePageState();
}

class _CompleteProfilePageState extends State<CompleteProfilePage> {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController dobController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final List<String> genders = ['Male', 'Female', 'Other'];

  String? selectedGender;
  File? profileImage;
  late final CompleteProfileCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = GetIt.I<CompleteProfileCubit>();
  }

  @override
  void dispose() {
    phoneController.dispose();
    dobController.dispose();
    _cubit.close();
    super.dispose();
  }

  Future<void> _selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );

    if (pickedDate == null) return;

    dobController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
  }

  void _submitProfile() {
    if (!formKey.currentState!.validate()) {
      return;
    }

    _cubit.completeProfile(
      userId: widget.userId,
      phoneNumber: phoneController.text.trim(),
      gender: selectedGender!,
      dob: dobController.text.trim(),
      profileImage: profileImage,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: BlocListener<CompleteProfileCubit, CompleteProfileState>(
        listener: (context, state) async {
          if (state.status == CompleteProfileStatus.success) {
            await SharedPrefService.setProfileComplete(true);

            if (!context.mounted) return;
            await context.pushReplacement(const AppBottomNav());
            return;
          }

          if (state.status == CompleteProfileStatus.failure &&
              state.errorMessage != null) {
            if (!context.mounted) return;
            context.showErrorSnackBar(state.errorMessage!);
          }
        },
        child: Scaffold(
          backgroundColor: AppColor.primary,
          appBar: AppAppBar(
            title: context.l10n.completeYourProfile,
            actions: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: InkWell(
                  onTap: () async {
                await SharedPrefService.setProfileComplete(true);
                if (!context.mounted) return;
                await context.pushReplacement(const AppBottomNav());
              },
              child: const Text('Skip'),
                ),
              ),
            ],
          ),
          body: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Column(
                      children: [
                        AppGap.g32,
                        Expanded(
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Container(
                                width: double.infinity,
                                margin: const EdgeInsets.only(top: 60),
                                padding: const EdgeInsets.only(
                                  top: 80,
                                  left: 24,
                                  right: 24,
                                  bottom: 24,
                                ),
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(30),
                                  ),
                                ),
                                child: Form(
                                  key: formKey,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Personal Information',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.grey.shade500,
                                        ),
                                      ),
                                      AppGap.g20,
                                      _buildLabel(context.l10n.mobileNumber),
                                      _buildPhoneField(),
                                      AppGap.g20,
                                      _buildLabel(context.l10n.dateOfBirth),
                                      _buildDobField(),
                                      AppGap.g20,
                                      _buildLabel(context.l10n.selectGender),
                                      _buildGenderField(),
                                      const Spacer(),
                                      AppGap.g32,
                                      _buildContinueButton(),
                                      AppGap.g16,
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 0,
                                left: 0,
                                right: 0,
                                child: Align(child: _buildProfileImage()),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, left: 4),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 14,
          color: Colors.grey.shade600,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildProfileImage() {
    return GestureDetector(
      onTap: () {
        ImageSourcePicker.show(
          context,
          onImagePicked: (image) {
            setState(() {
              profileImage = image;
            });
          },
        );
      },
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: Stack(
          children: [
            CircleAvatar(
              radius: 55,
              backgroundColor: AppColor.primary.withAlpha(15),
              backgroundImage: profileImage != null
                  ? FileImage(profileImage!)
                  : null,
              child: profileImage == null
                  ? const Icon(Icons.person, size: 60, color: Colors.grey)
                  : null,
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: AppColor.primary,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: const Icon(
                  Icons.camera_alt_rounded,
                  color: Colors.white,
                  size: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPhoneField() {
    return AppFormField(
      controller: phoneController,
      hintText: 'Enter phone number', // Adjusted to look cleaner without prefix
      keyboardType: TextInputType.phone,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Required';
        }
        return null;
      },
    );
  }

  Widget _buildDobField() {
    return GestureDetector(
      onTap: _selectDate,
      child: AbsorbPointer(
        child: AppFormField(
          controller: dobController,
          hintText: 'YYYY-MM-DD',
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Required';
            }
            return null;
          },
        ),
      ),
    );
  }

  Widget _buildGenderField() {
    return FormField<String>(
      validator: (value) {
        if (selectedGender == null) {
          return 'Required';
        }
        return null;
      },
      builder: (state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: genders.map((gender) {
                final isSelected = selectedGender == gender;
                return Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedGender = gender;
                        state.didChange(gender);
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.only(
                        right: gender != genders.last ? 12 : 0,
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: isSelected
                              ? AppColor.primary
                              : Colors.grey.shade300,
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        gender,
                        style: TextStyle(
                          color: isSelected
                              ? AppColor.primary
                              : Colors.grey.shade500,
                          fontWeight: isSelected
                              ? FontWeight.bold
                              : FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            if (state.hasError)
              Padding(
                padding: const EdgeInsets.only(top: 8, left: 4),
                child: Text(
                  state.errorText!,
                  style: const TextStyle(color: AppColor.error, fontSize: 12),
                ),
              ),
          ],
        );
      },
    );
  }

  Widget _buildContinueButton() {
    return BlocBuilder<CompleteProfileCubit, CompleteProfileState>(
      builder: (context, state) {
        final isLoading = state.status == CompleteProfileStatus.loading;

        return AppElevatedButton(
          text: isLoading ? 'Saving...' : context.l10n.continueBtn,
          isEnabled: true,
          onPressed: isLoading ? null : _submitProfile,
        );
      },
    );
  }
}
