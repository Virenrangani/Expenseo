import 'package:flutter/cupertino.dart';

import '../../constant/string/app_string.dart';
import '../../constant/text_style/app_text_style.dart';

class AppTitle extends StatelessWidget {
  final TextStyle? style;

  AppTitle({super.key, this.style});

  @override
  Widget build(BuildContext context) {
    return Text(AppString.appName, style: style ?? AppTextStyles.h1());
  }
}
