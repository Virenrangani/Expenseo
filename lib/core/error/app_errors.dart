import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../extension/localization_extension.dart';

class AppErrors {
  static String handleException(FirebaseAuthException e, BuildContext context) {
    switch (e.code) {
      case 'invalid-email':
        return context.l10n.invalidEmail;

      case 'user-disabled':
        return context.l10n.userDisabled;

      case 'user-not-found':
        return context.l10n.userNotFound;

      case 'wrong-password':
        return context.l10n.wrongPassword;

      case 'email-already-in-use':
        return context.l10n.emailAlreadyInUse;

      case 'operation-not-allowed':
        return context.l10n.operationNotAllowed;

      case 'account-exists-with-different-credential':
        return context.l10n.accountExistsWithDifferentCredential;

      case 'invalid-credential':
        return context.l10n.invalidCredential;

      default:
        return context.l10n.somethingWentWrong;
    }
  }

  static String handleFireStoreException(
    FirebaseException e,
    BuildContext context,
  ) {
    switch (e.code) {
      case 'permission-denied':
        return context.l10n.permissionDenied;

      case 'not-found':
        return context.l10n.dataNotFound;

      case 'already-exists':
        return context.l10n.dataAlreadyExists;

      case 'resource-exhausted':
        return context.l10n.resourceExhausted;

      case 'unavailable':
        return context.l10n.serviceUnavailable;

      case 'cancelled':
        return context.l10n.operationCancelled;

      case 'email-already-in-use':
        return context.l10n.emailAlreadyInUse;

      case 'invalid-credential':
        return context.l10n.invalidCredential;

      case 'deadline-exceeded':
        return context.l10n.timeout;

      case 'invalid-argument':
        return context.l10n.invalidArgument;

      case 'aborted':
        return context.l10n.operationAborted;

      default:
        return context.l10n.somethingWentWrong;
    }
  }
}
