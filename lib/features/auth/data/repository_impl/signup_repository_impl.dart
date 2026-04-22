import 'package:expenseo/features/auth/data/data_source/sign_up_data_source.dart';
import 'package:expenseo/features/auth/domain/entity/user.dart';
import 'package:expenseo/features/auth/domain/repository/sign_up_repository.dart';

class SignUpRepositoryImpl implements SignUpRepository{
  final SignUpDataSource signUpDataSource;
  SignUpRepositoryImpl(this.signUpDataSource);

  @override
  Future<User> signUp(String email, String name, String password) async {
    final model = await signUpDataSource.signUp(email, name, password);
    return User(id: model.id, email: model.email, name: model.name);
  }
}