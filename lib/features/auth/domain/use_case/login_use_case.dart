import 'package:expenseo/features/auth/domain/entity/user.dart';
import 'package:expenseo/features/auth/domain/repository/log_in_repository.dart';

class LoginUseCase {
  final LogInRepository repository;
  LoginUseCase(this.repository);

  Future<User> loginWithEmail(String email, String password) {
    return repository.login(email, password);
  }

  Future<User> loginWithGoogle() {
    return repository.signInWithGoogle();
  }
}
