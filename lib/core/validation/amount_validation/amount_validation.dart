import 'package:flutter/cupertino.dart';

import '../../extension/localization_extension.dart';

String? validateAmount(String amount, BuildContext context) {
  final value = amount.trim();

  if (value.isEmpty) return context.l10n.amountRequired;

  final parsed = double.tryParse(value);
  if (parsed == null) return context.l10n.amountInvalid;

  if (parsed <= 0) return context.l10n.amountGreaterThanZero;

  return null;
}
