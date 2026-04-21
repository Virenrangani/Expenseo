import 'package:expenseo/features/auth/data/data_source/login_data_source.dart';
import 'package:expenseo/features/auth/data/repository_impl/login_repository_impl.dart';
import 'package:expenseo/features/auth/domain/repository/log_in_repository.dart';
import 'package:expenseo/features/auth/domain/use_case/login_use_case.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import '../features/auth/presentation/cubit/login_cubit.dart';

class Injection {
  final GetIt sl=GetIt.instance;

  void configDependency(){

    sl.registerLazySingleton(()=>FirebaseAuth);

    sl.registerLazySingleton<LoginDataSource>(()=>LoginDataSourceImpl(sl()));
    sl.registerLazySingleton<LogInRepository>(()=>LoginRepositoryImpl(sl()));
    sl.registerLazySingleton(()=>LoginUseCase(sl()));
    sl.registerFactory(()=>LoginCubit(sl()));

  }
}