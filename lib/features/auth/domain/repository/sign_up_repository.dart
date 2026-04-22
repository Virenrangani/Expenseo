import '../entity/user.dart';

abstract class SignUpRepository {
  Future<User> signUp(String name,String email,String password);
}