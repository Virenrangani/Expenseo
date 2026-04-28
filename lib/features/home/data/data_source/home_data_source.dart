import 'package:expenseo/core/storage/shared_pref/shared_pref_service.dart';

abstract class HomeDataSource {
  Future<String?> getUserName();
}

class HomeDataSourceImpl implements HomeDataSource{
  @override
  Future<String?> getUserName() async {
    try{

      return await SharedPrefService.getUserName();

    }catch(e){
      throw Exception(e.toString());
    }
  }
}