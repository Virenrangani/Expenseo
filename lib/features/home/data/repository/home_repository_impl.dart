import 'package:expenseo/features/home/data/data_source/home_data_source.dart';
import 'package:expenseo/features/home/domain/repository/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository{
  final HomeDataSource homeDataSource;

  HomeRepositoryImpl(this.homeDataSource);
  @override
  Future<String?> getUserName() async {
    return  await homeDataSource.getUserName();
  }
}