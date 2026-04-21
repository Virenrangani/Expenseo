import '../entity/user.dart';

abstract class LogInRepository {
  Future<User> login(String email,String password);
}