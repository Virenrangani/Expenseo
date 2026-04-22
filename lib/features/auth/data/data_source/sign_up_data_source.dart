import 'package:firebase_auth/firebase_auth.dart';
import '../../../../core/constant/string/app_string.dart';
import '../model/user_model.dart';
import '../../../../core/error/app_errors.dart';

abstract class SignUpDataSource {
  Future<UserModel> signUp(String email, String name, String password);
}

class SignUpDataSourceImpl implements SignUpDataSource{
  final FirebaseAuth firebaseAuth;
  SignUpDataSourceImpl(this.firebaseAuth);

  Future<UserModel> signUp(String email, String name, String password) async {
    try {
      UserCredential credential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      final user = credential.user;
      if (user == null) throw Exception(AppString.userNotFound);

      await user.updateDisplayName(name);
      await user.reload();

      await user.sendEmailVerification();

      return UserModel(
          id: user.uid,
          email: user.email??"",
          name: user.displayName??""
      );
    } on FirebaseAuthException catch(e) {
      throw Exception(AppErrors.handleException(e))
    } catch (e) {
      throw Exception(AppString.somethingWentWrong);
    }
  }
}