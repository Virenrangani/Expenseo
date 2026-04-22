import '../../constant/string/app_string.dart';

String? validateEmail(String email) {
  final emailValue = email.trim().toLowerCase();

  if (emailValue.isEmpty) return AppString.emailRequired;
  if (emailValue.contains(" ")) return AppString.emailNotContainsSpace;

  final regex = RegExp(r'^[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$');

  if (!regex.hasMatch(emailValue)) {
    return AppString.emailInvalid;
  }

  return null;
}
