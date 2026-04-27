import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../../core/constant/string/app_string.dart';
import '../../../../core/error/app_errors.dart';
import '../model/user_model.dart';

abstract class LoginDataSource {
  Future<UserModel> login(String email, String password);
  Future<UserModel> signInWithGoogle();
}

class LoginDataSourceImpl extends LoginDataSource {
  final FirebaseAuth firebaseAuth;

  LoginDataSourceImpl(this.firebaseAuth);

  @override
  Future<UserModel> login(String email, String password) async {
    try {
      final result = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = result.user!;

      if (!user.emailVerified) {
        await firebaseAuth.signOut();
        throw Exception(AppString.userNotVerify);
      }

      return UserModel(
        id: user.uid,
        email: user.email ?? '',
        name: user.displayName ?? '',
      );
    } on FirebaseAuthException catch (e) {
      throw Exception(AppErrors.handleException(e));
    } catch (e) {
      throw Exception(AppString.somethingWentWrong);
    }
  }

  @override
  Future<UserModel> signInWithGoogle() async {
    try {
      await GoogleSignIn().signOut();
      final googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) throw Exception(AppString.googleSignInFailed);

      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await firebaseAuth.signInWithCredential(
        credential,
      );
      final user = userCredential.user;

      if (user == null) throw Exception(AppString.userNotFound);

      return UserModel(
        id: user.uid,
        email: user.email ?? '',
        name: user.displayName ?? '',
      );
    } on FirebaseAuthException catch (e) {
      throw Exception(AppErrors.handleException(e));
    } catch (e) {
      throw Exception(AppString.somethingWentWrong);
    }
  }
}
