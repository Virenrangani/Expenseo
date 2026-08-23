import 'package:flutter/cupertino.dart';

import '../../extension/localization_extension.dart';

String? validatePassword(String password, BuildContext context) {
  if (password.isEmpty) return context.l10n.passwordRequired;
  if (password.length < 8) return context.l10n.passwordMinChar;
  if (password.contains(' ')) return context.l10n.passwordNotContainsSpace;

  if (!RegExp('[A-Z]').hasMatch(password)) {
    return context.l10n.atLeastOneUpperCase;
  }

  if (!RegExp('[a-z]').hasMatch(password)) {
    return context.l10n.atLeastOneUpperCase;
  }

  if (!RegExp('[0-9]').hasMatch(password)) {
    return context.l10n.atLeastOneNumber;
  }

  if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password)) {
    return context.l10n.atLeastOneSpecialChar;
  }

  return null;
}
