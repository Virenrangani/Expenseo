import '../../domain/use_case/expense_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import './expense_state.dart';
import '../../domain/entity/expense.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ExpenseCubit extends Cubit<ExpenseState>{
  final ExpenseUseCase useCase;
  ExpenseCubit(this.useCase):super(ExpenseInitial());

  String get currentUid => FirebaseAuth.instance.currentUser!.uid;

  Future<void> addNewExpense(Expense expense) async {
    emit(ExpenseLoading());
    try{
      await useCase.addExpense(currentUid,expense);
      emit(ExpenseSuccess("Expense is added..!"));
    }catch (e){
      emit(ExpenseError(e.toString()));
    }

  }
}