import 'dart:io';

import 'package:flutter/foundation.dart';

String getDeviceType() {
  if (kIsWeb) return 'WEB';
  if (Platform.isAndroid) return 'ANDROID';
  if (Platform.isIOS) return 'IOS';
  return 'UNKNOWN';
}
