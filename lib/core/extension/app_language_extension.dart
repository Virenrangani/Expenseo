import 'package:flutter/cupertino.dart';

import '../enums/app_language.dart';
import 'localization_extension.dart';

extension AppLanguageExtension on AppLanguage {
  String getName(BuildContext context) {
    switch (this) {
      case AppLanguage.english:
        return context.l10n.english;
      case AppLanguage.arabic:
        return context.l10n.arabic;
      case AppLanguage.hindi:
        return context.l10n.hindi;
    }
  }
}
