import '../../constant/string/app_string.dart';

String? validateAmount(String amount) {
  final value = amount.trim();

  if (value.isEmpty) return AppString.amountRequired;

  final parsed = double.tryParse(value);
  if (parsed == null) return AppString.amountInvalid;

  if (parsed <= 0) return AppString.amountGreaterThanZero;

  return null;
}