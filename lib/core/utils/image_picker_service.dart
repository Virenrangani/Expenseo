import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class ImagePickerService {
  final ImagePicker _picker = ImagePicker();

  Future<File?> pickImage(ImageSource source) async {
    // 1. Handle Permissions
    final bool hasPermission = await _handlePermissions(source);
    if (!hasPermission) return null;

    // 2. Pick Image
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        imageQuality: 80,
        maxWidth: 1000,
        maxHeight: 1000,
      );

      if (pickedFile != null) {
        return File(pickedFile.path);
      }
    } catch (e) {
      // Log error or handle platform exceptions
      return null;
    }
    return null;
  }

  Future<bool> _handlePermissions(ImageSource source) async {
    Permission permission;
    if (source == ImageSource.camera) {
      permission = Permission.camera;
    } else {
      // For Gallery
      if (Platform.isIOS) {
        permission = Permission.photos;
      } else {
        permission = Permission.photos;
      }
    }

    PermissionStatus status = await permission.status;

    if (status.isGranted) return true;

    if (status.isDenied) {
      status = await permission.request();
      if (status.isGranted) return true;
    }

    if (status.isPermanentlyDenied) {
      await openAppSettings();
      return false;
    }

    return status.isGranted;
  }
}
