import 'dart:io';

import 'package:expenseo/core/constant/colour/app_color.dart';
import 'package:expenseo/core/constant/gap/app_gap.dart';
import 'package:expenseo/core/constant/padding/app_padding.dart';
import 'package:expenseo/core/storage/shared_pref/shared_pref_service.dart';
import 'package:expenseo/core/widget/elevated_button/app_elevated_button.dart';
import 'package:expenseo/core/widget/text_field/app_text_field.dart';
import 'package:expenseo/features/bottom_nav/app_bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../../core/extension/localization_extension.dart';
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

  @override
  void dispose() {
    phoneController.dispose();
    dobController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();

    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (pickedFile == null) return;

    setState(() {
      profileImage = File(pickedFile.path);
    });
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

    context.read<CompleteProfileCubit>().completeProfile(
      userId: widget.userId,
      phoneNumber: phoneController.text.trim(),
      gender: selectedGender!,
      dob: dobController.text.trim(),
      profileImage: profileImage,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CompleteProfileCubit, CompleteProfileState>(
      listener: (context, state) async {
        if (state.status == CompleteProfileStatus.success) {
          await SharedPrefService.setProfileComplete(true);

          if (!context.mounted) return;

          await Navigator.of(context).pushReplacement(
            MaterialPageRoute<void>(builder: (_) => const AppBottomNav()),
          );
        }

        if (state.status == CompleteProfileStatus.failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage ?? 'Something went wrong'),
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: AppColor.background,
        appBar: AppBar(
          title: Text(context.l10n.completeYourProfile),
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: AppPadding.edgeAll24,
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  _buildProfileImage(),

                  AppGap.g32,

                  _buildPhoneField(),

                  AppGap.g20,

                  _buildDobField(),

                  AppGap.g20,

                  _buildGenderField(),

                  AppGap.g32,

                  _buildContinueButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileImage() {
    return GestureDetector(
      onTap: _pickImage,
      child: CircleAvatar(
        radius: 60,
        backgroundColor: Colors.grey[200],
        backgroundImage: profileImage != null ? FileImage(profileImage!) : null,
        child: profileImage == null
            ? const Icon(Icons.add_a_photo, size: 40, color: AppColor.primary)
            : null,
      ),
    );
  }

  Widget _buildPhoneField() {
    return AppFormField(
      controller: phoneController,
      hintText: context.l10n.mobileNumber,
      keyboardType: TextInputType.phone,
      prefix: const Icon(Icons.phone, size: 20),
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
          hintText: context.l10n.dateOfBirth,
          prefix: const Icon(Icons.calendar_today, size: 20),
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
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        hintText: context.l10n.selectGender,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        prefixIcon: const Icon(Icons.person_outline),
      ),
      items: genders.map((gender) {
        return DropdownMenuItem<String>(value: gender, child: Text(gender));
      }).toList(),
      onChanged: (value) {
        setState(() {
          selectedGender = value;
        });
      },
      validator: (value) {
        if (value == null) {
          return 'Required';
        }

        return null;
      },
    );
  }

  Widget _buildContinueButton() {
    return BlocBuilder<CompleteProfileCubit, CompleteProfileState>(
      builder: (context, state) {
        final isLoading = state.status == CompleteProfileStatus.loading;

        return AppElevatedButton(
          text: isLoading ? 'Saving...' : context.l10n.continueBtn,
          onPressed: isLoading ? null : _submitProfile,
        );
      },
    );
  }
}
