import 'package:expenseo/features/auth/domain/repository/sign_up_repository.dart';
import 'package:expenseo/features/auth/domain/entity/user.dart';

class SignUpUseCase {
  final SignUpRepository signUpRepository;
  SignUpUseCase(this.signUpRepository);

  Future<User> signUpWithEmail(String name, String email, String password) {
    return signUpRepository.signUp(name, email, password);
  }
}
