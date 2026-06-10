import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:expenseo/core/dio/token_storage_impl.dart';
import 'package:expenseo/features/auth/data/data_source/login_data_source.dart';
import 'package:expenseo/features/auth/data/data_source/otp_remote_data_source.dart';
import 'package:expenseo/features/auth/data/repository_impl/login_repository_impl.dart';
import 'package:expenseo/features/auth/data/repository_impl/otp_repository_impl.dart';
import 'package:expenseo/features/auth/data/repository_impl/signup_repository_impl.dart';
import 'package:expenseo/features/auth/domain/repository/log_in_repository.dart';
import 'package:expenseo/features/auth/domain/repository/otp_repository.dart';
import 'package:expenseo/features/auth/domain/repository/sign_up_repository.dart';
import 'package:expenseo/features/auth/domain/use_case/login_use_case.dart';
import 'package:expenseo/features/auth/domain/use_case/otp_verify_use_case.dart';
import 'package:expenseo/features/auth/domain/use_case/sign_up_use_case.dart';
import 'package:expenseo/features/auth/presentation/cubit/otp_cubit.dart';
import 'package:expenseo/features/expense/data/data_source/expense_data_source.dart';
import 'package:expenseo/features/expense/data/repository_impl/expense_repository_impl.dart';
import 'package:expenseo/features/expense/domain/repository/expense_repository.dart';
import 'package:expenseo/features/expense/domain/use_case/expense_use_case.dart';
import 'package:expenseo/features/expense/presentation/cubit/expense_cubit.dart';
import 'package:expenseo/features/home/data/data_source/home_data_source.dart';
import 'package:expenseo/features/home/data/repository/home_repository_impl.dart';
import 'package:expenseo/features/home/domain/repository/home_repository.dart';
import 'package:expenseo/features/home/domain/use_case/home_use_case.dart';
import 'package:expenseo/features/home/presentation/cubit/home_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

import '../core/dio/dio_client.dart';
import '../core/dio/token_storage.dart';
import '../features/auth/data/data_source/sign_up_remote_data_source.dart';
import '../features/auth/presentation/cubit/login_cubit.dart';
import '../features/auth/presentation/cubit/sign_up_cubit.dart';

class Injection {
  final GetIt sl = GetIt.instance;

  void configDependency() {
    sl
      ..registerLazySingleton(() => FirebaseAuth.instance)
      ..registerLazySingleton(() => FirebaseFirestore.instance)
    ..registerLazySingleton<TokenStorage>(
          TokenStorageImpl.new)

   ..registerLazySingleton<Dio>(
          () => DioClient.create(sl()))
      ..registerLazySingleton<LoginDataSource>(
        () => LoginDataSourceImpl(sl(), sl()),
      )
      ..registerLazySingleton<LogInRepository>(() => LoginRepositoryImpl(sl()))
      ..registerLazySingleton(() => LoginUseCase(sl()))
      ..registerFactory(() => LoginCubit(sl()))
      ..registerLazySingleton<SignUpRemoteDataSource>(
        () => SignUpRemoteDataSourceImpl(sl()),
      )
      ..registerLazySingleton<SignUpRepository>(
        () => SignUpRepositoryImpl(sl()),
      )
      ..registerLazySingleton(() => SignUpUseCase(sl()))
      ..registerFactory(() => SignUpCubit(sl()))
      ..registerLazySingleton<ExpenseDataSource>(
        () => ExpenseDataSourceImpl(sl()),
      )
      ..registerLazySingleton<ExpenseRepository>(
        () => ExpenseRepositoryImpl(sl()),
      )
      ..registerLazySingleton(() => ExpenseUseCase(sl()))
      ..registerFactory(() => ExpenseCubit(sl()))
      ..registerLazySingleton<HomeDataSource>(HomeDataSourceImpl.new)
      ..registerLazySingleton<HomeRepository>(() => HomeRepositoryImpl(sl()))
      ..registerLazySingleton(() => HomeUseCase(sl()))
      ..registerFactory(() => HomeCubit(sl()))
      ..registerLazySingleton<OtpRemoteDataSource>(
        () => OtpRemoteDataSourceImpl(sl()),
      )
      ..registerLazySingleton<OtpRepository>(() => OtpRepositoryImpl(sl()))
      ..registerLazySingleton(() => VerifyOtpUseCase(sl()))
      ..registerFactory(() => OtpCubit(sl()));
  }
}
