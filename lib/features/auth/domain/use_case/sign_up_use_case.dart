import 'package:expenseo/features/auth/domain/repository/sign_up_repository.dart';

class SignUpUseCase {
  final SignUpRepository signUpRepository;
  SignUpUseCase(this.signUpRepository);

  Future<void> signUpWithEmail(String name, String email, String password) {
    return signUpRepository.signUp(name, email, password);
  }
}
