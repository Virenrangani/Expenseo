import 'dart:convert';
import 'dart:io';

import 'package:mime/mime.dart' show lookupMimeType;

Future<String> fileToBase64DataUrl(File file) async {
  final bytes = await file.readAsBytes();
  final mimeType = lookupMimeType(file.path) ?? 'image/jpeg';
  final base64Str = base64Encode(bytes);
  return 'data:$mimeType;base64,$base64Str';
}
