import 'package:flutter/cupertino.dart';

import '../../extension/localization_extension.dart';

String? validateEmail(String email, BuildContext context) {
  final emailValue = email.trim().toLowerCase();

  if (emailValue.isEmpty) return context.l10n.emailRequired;
  if (emailValue.contains(' ')) return context.l10n.emailNotContainsSpace;

  final regex = RegExp(r'^[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$');

  if (!regex.hasMatch(emailValue)) {
    return context.l10n.emailInvalid;
  }

  return null;
}
