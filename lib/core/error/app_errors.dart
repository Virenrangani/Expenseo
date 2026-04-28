import 'package:firebase_auth/firebase_auth.dart';

import '../constant/string/app_string.dart';

class AppErrors {
  static String handleException(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-email':
        return AppString.invalidEmail;

      case 'user-disabled':
        return AppString.userDisabled;

      case 'user-not-found':
        return AppString.userNotFound;

      case 'wrong-password':
        return AppString.wrongPassword;

      case 'email-already-in-use':
        return AppString.emailAlreadyInUse;

      case 'operation-not-allowed':
        return AppString.operationNotAllowed;

      case 'account-exists-with-different-credential':
        return AppString.accountExistsWithDifferentCredential;

      case 'invalid-credential':
        return AppString.invalidCredential;

      default:
        return AppString.somethingWentWrong;
    }
  }

  static String handleFireStoreException(FirebaseException e) {
    switch (e.code) {

      case 'permission-denied':
        return AppString.permissionDenied;

      case 'not-found':
        return AppString.dataNotFound;

      case 'already-exists':
        return AppString.dataAlreadyExists;

      case 'resource-exhausted':
        return AppString.resourceExhausted;

      case 'unavailable':
        return AppString.serviceUnavailable;

      case 'cancelled':
        return AppString.operationCancelled;

      case 'deadline-exceeded':
        return AppString.timeout;

      case 'invalid-argument':
        return AppString.invalidArgument;

      case 'aborted':
        return AppString.operationAborted;

      default:
        return AppString.somethingWentWrong;
    }
  }
}
