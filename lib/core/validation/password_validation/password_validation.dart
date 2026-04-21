
import '../../constant/string/app_string.dart';

String? validatePassword(String password) {
  if (password.isEmpty) return AppString.passwordRequired;
  if (password.length < 8) return AppString.passwordMinChar;
  if(password.contains(" ")) return AppString.passwordNotContainsSpace;

  if (!RegExp(r'[A-Z]').hasMatch(password)) {
    return AppString.atLeastOneUpperCase;
  }

  if (!RegExp(r'[a-z]').hasMatch(password)) {
    return AppString.atLeastOneUpperCase;
  }

  if (!RegExp(r'[0-9]').hasMatch(password)) {
    return AppString.atLeastOneNumber;
  }

  if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password)) {
    return AppString.atLeastOneSpecialChar;
  }

  return null;
}