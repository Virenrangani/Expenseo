import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:expenseo/core/dio/token_storage_impl.dart';
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
import 'package:expenseo/features/expense/data/repository_impl/expense_repository_impl.dart';
import 'package:expenseo/features/expense/domain/repository/expense_repository.dart';
import 'package:expenseo/features/expense/domain/use_case/expense_use_case.dart';
import 'package:expenseo/features/expense/presentation/cubit/expense_cubit.dart';
import 'package:expenseo/features/home/data/data_source/home_data_source.dart';
import 'package:expenseo/features/home/data/repository/home_repository_impl.dart';
import 'package:expenseo/features/home/domain/repository/home_repository.dart';
import 'package:expenseo/features/home/domain/use_case/home_use_case.dart';
import 'package:expenseo/features/home/presentation/cubit/home_cubit.dart';
import 'package:expenseo/features/split/data/data_source/split_data_source.dart';
import 'package:expenseo/features/split/data/repository_impl/split_repository_impl.dart';
import 'package:expenseo/features/split/domain/repository/split_repository.dart';
import 'package:expenseo/features/split/domain/use_case/split_use_case.dart';
import 'package:expenseo/features/split/presentation/cubit/split_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

import '../core/dio/dio_client.dart';
import '../core/dio/token_storage.dart';
import '../features/auth/data/data_source/login_remote_data_source.dart';
import '../features/auth/data/data_source/sign_up_remote_data_source.dart';
import '../features/auth/presentation/cubit/login_cubit.dart';
import '../features/auth/presentation/cubit/sign_up_cubit.dart';
import '../features/expense/data/data_source/expense_remote_data_source.dart';
import '../features/forgot_password/data/data_source/forgot_password_data_source.dart';
import '../features/forgot_password/data/repository_impl/forgot_password_repository_impl.dart';
import '../features/forgot_password/domain/repository/forgot_password_repository.dart';
import '../features/forgot_password/domain/use_case/forgot_password_use_case.dart';
import '../features/forgot_password/presentation/cubit/forgot_password_cubit.dart';

class Injection {
  final GetIt sl = GetIt.instance;

  void configDependency() {
    sl
      ..registerLazySingleton(() => FirebaseAuth.instance)
      ..registerLazySingleton(() => FirebaseFirestore.instance)
      ..registerLazySingleton<TokenStorage>(TokenStorageImpl.new)
      ..registerLazySingleton<Dio>(() => DioClient.create(tokenStorage: sl()))

      ..registerLazySingleton<LoginRemoteDataSource>(
        () => LoginRemoteDataSourceImpl(sl()),
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
      ..registerLazySingleton<ExpenseRemoteDataSource>(
        () => ExpenseRemoteDataSourceImpl(sl()),
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
      ..registerFactory(() => OtpCubit(sl()))
      ..registerLazySingleton<ForgotPasswordDataSource>(
        () => ForgotPasswordDataSourceImpl(sl()),
      )
      ..registerLazySingleton<ForgotPasswordRepository>(
        () => ForgotPasswordRepositoryImpl(sl()),
      )
      ..registerLazySingleton(() => ForgotPasswordUseCase(sl()))
      ..registerFactory(() => ForgotPasswordCubit(sl()))

        ..registerLazySingleton<SplitDataSource>(()=> SplitDataSourceImpl(sl()))
        ..registerLazySingleton<SplitRepository>(()=> SplitRepositoryImpl(sl()))
        ..registerLazySingleton(()=> SplitUseCase(sl()))
        ..registerFactory(()=> SplitCubit(sl()));
  }
}
