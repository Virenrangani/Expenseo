import 'package:expenseo/features/auth/data/data_source/login_remote_data_source.dart';
import 'package:expenseo/features/auth/domain/entity/user.dart';
import 'package:expenseo/features/auth/domain/repository/log_in_repository.dart';

class LoginRepositoryImpl extends LogInRepository {
  final LoginRemoteDataSource dataSource;

  LoginRepositoryImpl(this.dataSource);

  @override
  Future<User> login(String email, String password) async {
    final result = await dataSource.login(email, password);
    return User(id: result.id, email: result.email);
  }
}
