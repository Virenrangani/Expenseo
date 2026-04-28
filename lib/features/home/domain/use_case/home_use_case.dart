import 'package:expenseo/features/home/domain/repository/home_repository.dart';

class HomeUseCase {
  final HomeRepository homeRepository;

  HomeUseCase(this.homeRepository);

  Future<String?> getUserName(){

    return homeRepository.getUserName();
  }
}