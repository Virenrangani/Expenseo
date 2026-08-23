import 'dart:io';

import 'package:expenseo/core/constant/colour/app_color.dart';
import 'package:expenseo/core/constant/gap/app_gap.dart';
import 'package:expenseo/core/constant/padding/app_padding.dart';
import 'package:expenseo/core/storage/shared_pref/shared_pref_service.dart';
import 'package:expenseo/core/widget/elevated_button/app_elevated_button.dart';
import 'package:expenseo/core/widget/text_field/app_text_field.dart';
import 'package:expenseo/features/bottom_nav/app_bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../../core/extension/localization_extension.dart';

class CompleteProfilePage extends StatefulWidget {
  const CompleteProfilePage({super.key});

  @override
  State<CompleteProfilePage> createState() => _CompleteProfilePageState();
}

class _CompleteProfilePageState extends State<CompleteProfilePage> {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  String? selectedGender;
  File? profileImage;
  final formKey = GlobalKey<FormState>();

  final List<String> genders = ['Male', 'Female', 'Other'];

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        profileImage = File(pickedFile.path);
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        dobController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        title: Text(context.l10n.completeYourProfile),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: AppPadding.edgeAll24,
        child: Form(
          key: formKey,
          child: Column(
            children: [
              GestureDetector(
                onTap: _pickImage,
                child: CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.grey[200],
                  backgroundImage: profileImage != null
                      ? FileImage(profileImage!)
                      : null,
                  child: profileImage == null
                      ? const Icon(
                          Icons.add_a_photo,
                          size: 40,
                          color: AppColor.primary,
                        )
                      : null,
                ),
              ),
              AppGap.g32,
              AppFormField(
                controller: phoneController,
                hintText: context.l10n.mobileNumber,
                keyboardType: TextInputType.phone,
                prefix: const Icon(Icons.phone, size: 20),
                validator: (value) =>
                    (value == null || value.isEmpty) ? 'Required' : null,
              ),
              AppGap.g20,
              GestureDetector(
                onTap: () => _selectDate(context),
                child: AbsorbPointer(
                  child: AppFormField(
                    controller: dobController,
                    hintText: context.l10n.dateOfBirth,
                    prefix: const Icon(Icons.calendar_today, size: 20),
                    validator: (value) =>
                        (value == null || value.isEmpty) ? 'Required' : null,
                  ),
                ),
              ),
              AppGap.g20,
              DropdownButtonFormField<String>(
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
                items: genders.map((category) {
                  return DropdownMenuItem(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    selectedGender = newValue;
                  });
                },
                validator: (value) => value == null ? 'Required' : null,
              ),
              AppGap.g32,
              AppElevatedButton(
                text: context.l10n.continueBtn,
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    final navigator = Navigator.of(context);
                    await SharedPrefService.setProfileComplete(true);
                    if (!mounted) return;
                    await navigator.pushReplacement(
                      MaterialPageRoute<void>(
                        builder: (context) => const AppBottomNav(),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
