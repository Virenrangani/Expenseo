import 'dart:io';

import 'package:expenseo/core/constant/colour/app_color.dart';
import 'package:expenseo/core/constant/gap/app_gap.dart';
import 'package:expenseo/core/utils/image_picker_service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageSourcePicker extends StatelessWidget {
  final void Function(File) onImagePicked;
  final ImagePickerService pickerService;

  ImageSourcePicker({
    super.key,
    required this.onImagePicked,
    ImagePickerService? pickerService,
  }) : pickerService = pickerService ?? ImagePickerService();

  static Future<void> show(
    BuildContext context, {
    required void Function(File) onImagePicked,
    ImagePickerService? pickerService,
  }) {
    return showModalBottomSheet<void>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => ImageSourcePicker(
        onImagePicked: onImagePicked,
        pickerService: pickerService,
      ),
    );
  }

  Future<void> _handlePick(BuildContext context, ImageSource source) async {
    final File? image = await pickerService.pickImage(source);
    if (image != null) {
      onImagePicked(image);
      if (context.mounted) Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Select Image Source',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            AppGap.g24,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildSourceOption(
                  context: context,
                  icon: Icons.camera_alt_rounded,
                  label: 'Camera',
                  onTap: () => _handlePick(context, ImageSource.camera),
                ),
                _buildSourceOption(
                  context: context,
                  icon: Icons.photo_library_rounded,
                  label: 'Gallery',
                  onTap: () => _handlePick(context, ImageSource.gallery),
                ),
              ],
            ),
            AppGap.g12,
          ],
        ),
      ),
    );
  }

  Widget _buildSourceOption({
    required BuildContext context,
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: AppColor.primary.withAlpha(25),
              child: Icon(icon, color: AppColor.primary, size: 28),
            ),
            AppGap.g8,
            Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }
}
