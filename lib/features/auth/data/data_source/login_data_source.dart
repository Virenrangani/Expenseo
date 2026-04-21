import 'package:expenseo/features/auth/domain/entity/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../core/constant/string/app_string.dart';
import '../model/user_model.dart';

abstract class LoginDataSource {
  Future<UserModel> login(String email,String password);
}

class LoginDataSourceImpl extends LoginDataSource{
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
          email: user.email ??"",
          name: user.displayName ??""
      );
    } on FirebaseAuthException {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

}