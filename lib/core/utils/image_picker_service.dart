import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class ImagePickerService {
  ImagePickerService();

  final ImagePicker _picker = ImagePicker();

  Future<File?> pickImage(ImageSource source) async {
    if (!await _handlePermissions(source)) return null;

    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        imageQuality: 80,
        maxWidth: 1000,
        maxHeight: 1000,
      );

      return pickedFile == null ? null : File(pickedFile.path);
    } catch (_) {
      return null;
    }
  }

  Future<bool> _handlePermissions(ImageSource source) async {
    final permission = source == ImageSource.camera
        ? Permission.camera
        : Permission.photos;

    final status = await permission.status;
    if (status.isGranted) return true;

    if (status.isDenied) {
      final requested = await permission.request();
      if (requested.isGranted) return true;
    }

    if (status.isPermanentlyDenied) {
      await openAppSettings();
      return false;
    }

    return status.isGranted;
  }
}
