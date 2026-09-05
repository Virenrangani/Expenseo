import 'package:flutter/material.dart';

import '../../../../core/constant/gap/app_gap.dart';
import '../../../../core/extension/localization_extension.dart';
import '../../../../core/widget/text_field/app_text_field.dart';
import 'complete_profile_widgets.dart';

class ProfileFormCard extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController phoneController;
  final TextEditingController dobController;
  final List<String> genders;
  final String? selectedGender;
  final ValueChanged<String> onGenderChanged;
  final VoidCallback onDateTap;
  final VoidCallback onSubmit;

  const ProfileFormCard({
    super.key,
    required this.formKey,
    required this.phoneController,
    required this.dobController,
    required this.genders,
    required this.selectedGender,
    required this.onGenderChanged,
    required this.onDateTap,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 60),
      padding: const EdgeInsets.only(top: 80, left: 24, right: 24, bottom: 24),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
            FormFieldLabel(text: context.l10n.mobileNumber),
            AppFormField(
              controller: phoneController,
              hintText: 'Enter phone number',
              keyboardType: TextInputType.phone,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Required';
                }
                return null;
              },
            ),
            AppGap.g20,
            FormFieldLabel(text: context.l10n.dateOfBirth),
            GestureDetector(
              onTap: onDateTap,
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
            ),
            AppGap.g20,
            FormFieldLabel(text: context.l10n.selectGender),
            GenderSelectorField(
              genders: genders,
              selectedGender: selectedGender,
              onGenderChanged: onGenderChanged,
            ),
            const Spacer(),
            AppGap.g32,
            CompleteProfileSubmitButton(onPressed: onSubmit),
            AppGap.g16,
          ],
        ),
      ),
    );
  }
}
