import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constant/colour/app_color.dart';
import '../../../../core/extension/localization_extension.dart';
import '../../../../core/widget/elevated_button/app_elevated_button.dart';
import '../../../../core/widget/image_source_picker/image_source_picker.dart';
import '../cubit/complete_profile_cubit.dart';
import '../cubit/complete_profile_state.dart';

class FormFieldLabel extends StatelessWidget {
  final String text;

  const FormFieldLabel({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
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
}

class EditableProfileAvatar extends StatelessWidget {
  final File? profileImage;
  final ValueChanged<File?> onImageSelected;

  const EditableProfileAvatar({
    super.key,
    required this.profileImage,
    required this.onImageSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ImageSourcePicker.show(context, onImagePicked: onImageSelected);
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
}

class GenderSelectorField extends StatelessWidget {
  final List<String> genders;
  final String? selectedGender;
  final ValueChanged<String> onGenderChanged;

  const GenderSelectorField({
    super.key,
    required this.genders,
    required this.selectedGender,
    required this.onGenderChanged,
  });

  @override
  Widget build(BuildContext context) {
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
                      onGenderChanged(gender);
                      state.didChange(gender);
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
}

class CompleteProfileSubmitButton extends StatelessWidget {
  final VoidCallback onPressed;

  const CompleteProfileSubmitButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CompleteProfileCubit, CompleteProfileState>(
      builder: (context, state) {
        final isLoading = state.status == CompleteProfileStatus.loading;

        return AppElevatedButton(
          text: isLoading ? 'Saving...' : context.l10n.continueBtn,
          isEnabled: true,
          onPressed: isLoading ? null : onPressed,
        );
      },
    );
  }
}
