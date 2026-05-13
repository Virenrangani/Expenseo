import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../../core/constant/string/app_string.dart';
import '../../../../core/error/app_errors.dart';
import '../../../../core/storage/shared_pref/shared_pref_service.dart';
import '../model/user_model.dart';

abstract class LoginDataSource {
  Future<UserModel> login(String email, String password);
  Future<UserModel> signInWithGoogle();
}

class LoginDataSourceImpl extends LoginDataSource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;

  LoginDataSourceImpl(this.firebaseAuth , this.firestore);

  @override
  Future<UserModel> login(String email, String password) async {
    try {

      final snapshot = await firestore
          .collection('users')
          .where('email', isEqualTo: email)
          .limit(1)
          .get();

      if (snapshot.docs.isNotEmpty) {

        final data = snapshot.docs.first.data();

        final provider =
            data['provider'] as String? ?? '';

        if (provider == 'google') {

          throw Exception();
        }
      }

      final result = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = result.user!;

      if (!user.emailVerified) {
        await firebaseAuth.signOut();
        throw Exception(AppString.userNotVerify);
      }

      final doc = await firestore
          .collection('users')
          .doc(user.uid)
          .get();

      final data = doc.data();

      final String name = data?['name'] as String? ?? '';

      await SharedPrefService.saveUser(
        id: user.uid,
        email: user.email ?? '',
        name: name,
      );

      return UserModel(
        id: user.uid,
        email: user.email ?? '',
        name: user.displayName ?? '',
      );
    } on FirebaseException catch (e) {
      throw Exception(AppErrors.handleFireStoreException(e));
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

      final doc = await firestore
          .collection('users')
          .doc(user.uid)
          .get();

      if (!doc.exists) {
        await firestore
            .collection('users')
            .doc(user.uid)
            .set({
          'id': user.uid,
          'name': user.displayName ?? '',
          'email': user.email ?? '',
          'createdAt': DateTime.now(),
        });
      }

      await SharedPrefService.saveUser(
        id: user.uid,
        email: user.email ?? '',
        name: user.displayName ?? '',
      );
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
