import 'package:expenseo/features/home/domain/use_case/home_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeUseCase homeUseCase;
  HomeCubit(this.homeUseCase) : super(HomeInitial());

  String userName='';

  Future<void> getUserName()async {
    emit(HomeLoading());
    try{
       final name = await homeUseCase.getUserName();
       userName=name ?? ' ';
       emit(HomeSuccess());
    }catch(e){
      emit(HomeError());
    }

  }
}

