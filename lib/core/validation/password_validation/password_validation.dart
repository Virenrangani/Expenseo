
import '../../constant/string/app_string.dart';

String? validatePassword(String password) {
  if (password.isEmpty) return AppString.passwordRequired;
  if (password.length < 8) return AppString.passwordMinChar;
  if(password.contains(' ')) return AppString.passwordNotContainsSpace;

  if (!RegExp('[A-Z]').hasMatch(password)) {
    return AppString.atLeastOneUpperCase;
  }

  if (!RegExp('[a-z]').hasMatch(password)) {
    return AppString.atLeastOneUpperCase;
  }

  if (!RegExp('[0-9]').hasMatch(password)) {
    return AppString.atLeastOneNumber;
  }

  if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password)) {
    return AppString.atLeastOneSpecialChar;
  }

  return null;
}