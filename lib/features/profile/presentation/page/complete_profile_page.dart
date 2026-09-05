import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

import '../../../../core/constant/colour/app_color.dart';
import '../../../../core/constant/gap/app_gap.dart';
import '../../../../core/extension/localization_extension.dart';
import '../../../../core/extension/snackbar_extension.dart';
import '../../../../core/navigation/app_navigation.dart';
import '../../../../core/storage/shared_pref/shared_pref_service.dart';
import '../../../../core/widget/app_app_bar.dart';
import '../../../../core/widget/text_field/app_text_field.dart';
import '../../../bottom_nav/app_bottom_nav.dart';
import '../cubit/complete_profile_cubit.dart';
import '../cubit/complete_profile_state.dart';
import '../widget/complete_profile_widgets.dart';

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

  final List<String> genders = const ['Male', 'Female', 'Other'];

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
    if (!formKey.currentState!.validate()) return;

    _cubit.completeProfile(
      userId: widget.userId,
      phoneNumber: phoneController.text.trim(),
      gender: selectedGender!,
      dob: dobController.text.trim(),
      profileImage: profileImage,
    );
  }

  Future<void> _onSkipPressed() async {
    await SharedPrefService.setProfileComplete(true);
    if (!mounted) return;
    await context.pushReplacement(const AppBottomNav());
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
                  onTap: _onSkipPressed,
                  child: const Center(
                    child: Text('Skip', style: TextStyle(color: Colors.white)),
                  ),
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
                              _ProfileFormCard(
                                formKey: formKey,
                                phoneController: phoneController,
                                dobController: dobController,
                                genders: genders,
                                selectedGender: selectedGender,
                                onGenderChanged: (gender) {
                                  setState(() => selectedGender = gender);
                                },
                                onDateTap: _selectDate,
                                onSubmit: _submitProfile,
                              ),
                              Positioned(
                                top: 0,
                                left: 0,
                                right: 0,
                                child: Align(
                                  child: EditableProfileAvatar(
                                    profileImage: profileImage,
                                    onImageSelected: (image) {
                                      setState(() => profileImage = image);
                                    },
                                  ),
                                ),
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
}

class _ProfileFormCard extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController phoneController;
  final TextEditingController dobController;
  final List<String> genders;
  final String? selectedGender;
  final ValueChanged<String> onGenderChanged;
  final VoidCallback onDateTap;
  final VoidCallback onSubmit;

  const _ProfileFormCard({
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
