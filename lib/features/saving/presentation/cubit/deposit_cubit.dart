import 'package:expenseo/features/saving/presentation/cubit/deposit_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecase/saving_use_case.dart';

class DepositCubit extends Cubit<DepositState> {
  final SavingUseCase savingGoalUseCase;

  DepositCubit(this.savingGoalUseCase) : super(DepositInitial());

  Future<void> getAllDeposit(String goalId) async {
    emit(DepositLoading());
    {
      try {
        final deposits = await savingGoalUseCase.getAllDeposit(goalId);

        emit(DepositLoaded(deposits));
      } catch (e) {
        emit(DepositError(e.toString()));
      }
    }
  }
}
