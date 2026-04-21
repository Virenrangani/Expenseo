import 'package:expenseo/features/auth/domain/entity/user.dart';
import 'package:expenseo/features/auth/domain/repository/log_in_repository.dart';

class LoginUseCase {
  final LogInRepository repository;
  LoginUseCase(this.repository);

  Future<User> callLogin(String email,String password){
    return repository.login(email, password);
  }

  Future<User> googleCall(){
    return repository.signInWithGoogle();
  }
}