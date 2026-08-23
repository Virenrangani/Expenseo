import 'package:flutter/cupertino.dart';

import '../../constant/text_style/app_text_style.dart';
import '../../extension/localization_extension.dart';

class AppTitle extends StatelessWidget {
  final TextStyle? style;

  const AppTitle({super.key, this.style});

  @override
  Widget build(BuildContext context) {
    return Text(context.l10n.appName, style: style ?? AppTextStyles.h1());
  }
}
