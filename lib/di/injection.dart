import 'package:expenseo/features/auth/data/data_source/login_data_source.dart';
import 'package:expenseo/features/auth/data/repository_impl/login_repository_impl.dart';
import 'package:expenseo/features/auth/domain/repository/log_in_repository.dart';
import 'package:expenseo/features/auth/domain/use_case/login_use_case.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import '../features/auth/presentation/cubit/login_cubit.dart';
import 'package:expenseo/features/auth/data/data_source/sign_up_data_source.dart';
import 'package:expenseo/features/auth/data/repository_impl/signup_repository_impl.dart';
import 'package:expenseo/features/auth/domain/repository/sign_up_repository.dart';
import 'package:expenseo/features/auth/domain/use_case/sign_up_use_case.dart';
import '../features/auth/presentation/cubit/sign_up_cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expenseo/features/expense/data/data_source/expense_data_source.dart';
import 'package:expenseo/features/expense/data/repository_impl/expense_repository_impl.dart';
import 'package:expenseo/features/expense/domain/repository/expense_repository.dart';
import 'package:expenseo/features/expense/domain/use_case/expense_use_case.dart';
import 'package:expenseo/features/expense/presentation/cubit/expense_cubit.dart';


class Injection {
  final GetIt sl=GetIt.instance;

  void configDependency(){

    sl.registerLazySingleton(()=>FirebaseAuth.instance);
    sl.registerLazySingleton(()=>FirebaseFirestore.instance);

    sl.registerLazySingleton<LoginDataSource>(()=>LoginDataSourceImpl(sl()));
    sl.registerLazySingleton<LogInRepository>(()=>LoginRepositoryImpl(sl()));
    sl.registerLazySingleton(()=>LoginUseCase(sl()));
    sl.registerFactory(()=>LoginCubit(sl()));

    sl.registerLazySingleton<SignUpDataSource>(()=>SignUpDataSourceImpl(sl()));
    sl.registerLazySingleton<SignUpRepository>(()=>SignUpRepositoryImpl(sl()));
    sl.registerLazySingleton(()=>SignUpUseCase(sl()));
    sl.registerFactory(()=>SignUpCubit(sl()));

    sl.registerLazySingleton<ExpenseDataSource>(()=>ExpenseDataSourceImpl(sl()));
    sl.registerLazySingleton<ExpenseRepository>(()=>ExpenseRepositoryImpl(sl()));
    sl.registerLazySingleton(()=>ExpenseUseCase(sl()));
    sl.registerFactory(()=>ExpenseCubit(sl()));
  }
}