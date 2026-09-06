import 'package:expenseo/core/utils/widget_utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/enums/app_enums.dart';
import '../../../../core/enums/expense_filter_enums.dart';
import '../../domain/entity/expense.dart';
import '../../domain/use_case/expense_use_case.dart';
import './expense_state.dart';

class ExpenseCubit extends Cubit<ExpenseState> {
  final ExpenseUseCase useCase;
  ExpenseCubit(this.useCase) : super(ExpenseInitial());

  DateFilter selectedDateFilter = DateFilter.all;
  TypeFilter selectedTypeFilter = TypeFilter.all;
  CategoryFilter selectedCategoryFilter = CategoryFilter.all;
  PaymentType selectedPaymentFilter = PaymentType.all;

  String searchQuery = '';

  List<Expense> allExpenses = [];
  List<Expense> filteredExpenses = [];

  TransactionType type = TransactionType.expense;
  ExpenseCategory category = ExpenseCategory.food;
  PaymentMethod paymentMethod = PaymentMethod.cash;

  double totalIncome = 0;
  double totalExpense = 0;

  final int recentTransactionCount = 4;

  Future<void> addNewExpense(Expense expense) async {
    emit(ExpenseLoading());
    try {
      await useCase.addExpense(expense);
      emit(ExpenseSuccess('Expense Added Successfully'));
      await getExpense();
    } catch (e) {
      emit(ExpenseError(e.toString()));
    }
  }

  Future<void> getExpense() async {
    emit(ExpenseLoading());
    try {
      final expense = await useCase.getExpense();
      expense.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      totalIncome = 0;
      totalExpense = 0;
      allExpenses = expense;
      getTotalIncomeExpense(expense);

      final balance = totalIncome - totalExpense;
      await WidgetUtils.updateWidget(
        balance: '\$${balance.toStringAsFixed(2)}',
        income: '\$${totalIncome.toStringAsFixed(2)}',
        expense: '\$${totalExpense.toStringAsFixed(2)}',
      );

      applyFilters(
        dateFilter: selectedDateFilter,
        typeFilter: selectedTypeFilter,
        categoryFilter: selectedCategoryFilter,
        paymentFilter: selectedPaymentFilter,
      );
    } catch (e) {
      emit(ExpenseError(e.toString()));
    }
  }

  Future<void> removeExpense(String expenseId) async {
    emit(ExpenseLoading());
    try {
      await useCase.removeExpense(expenseId);
      emit(ExpenseSuccess('Expense Removed...!'));
      await getExpense();
    } catch (e) {
      emit(ExpenseError(e.toString()));
    }
  }

  void getTotalIncomeExpense(List<Expense> expense) {
    for (final item in expense) {
      if (item.type == TransactionType.income) {
        totalIncome = totalIncome + item.amount;
      } else if (item.type == TransactionType.expense) {
        totalExpense = totalExpense + item.amount;
      }
    }
  }

  void searchExpense(String query) {
    searchQuery = query.toLowerCase();

    applyFilters(
      dateFilter: selectedDateFilter,
      typeFilter: selectedTypeFilter,
      categoryFilter: selectedCategoryFilter,
      paymentFilter: selectedPaymentFilter,
    );
  }

  Future<void> getExpensesByDate(DateTime date) async {
    emit(ExpenseLoading());
    try {
      final allExpenses = await useCase.getExpense();

      final filtered = allExpenses.where((e) {
        final local = e.createdAt;
        return local.year == date.year &&
            local.month == date.month &&
            local.day == date.day;
      }).toList();

      emit(ExpenseLoaded(filtered));
    } catch (e) {
      emit(ExpenseError(e.toString()));
    }
  }

  void applyFilters({
    required DateFilter dateFilter,
    required TypeFilter typeFilter,
    required CategoryFilter categoryFilter,
    required PaymentType paymentFilter,
  }) {
    selectedDateFilter = dateFilter;
    selectedTypeFilter = typeFilter;
    selectedCategoryFilter = categoryFilter;
    selectedPaymentFilter = paymentFilter;

    List<Expense> result = List.from(allExpenses);

    if (dateFilter == DateFilter.today) {
      final now = DateTime.now();
      result = result.where((e) {
        final dt = e.createdAt.toLocal();
        return dt.day == now.day &&
            dt.month == now.month &&
            dt.year == now.year;
      }).toList();
    } else if (dateFilter == DateFilter.week) {
      final now = DateTime.now();
      result = result.where((e) {
        final dt = e.createdAt.toLocal();
        return now.difference(dt).inDays <= 7;
      }).toList();
    } else if (dateFilter == DateFilter.month) {
      final now = DateTime.now();
      result = result.where((e) {
        final dt = e.createdAt.toLocal();
        return dt.month == now.month && dt.year == now.year;
      }).toList();
    }

    if (typeFilter == TypeFilter.income) {
      result = result.where((e) {
        return e.type == TransactionType.income;
      }).toList();
    } else if (typeFilter == TypeFilter.expense) {
      result = result.where((e) {
        return e.type == TransactionType.expense;
      }).toList();
    }

    if (categoryFilter != CategoryFilter.all) {
      result = result.where((e) {
        return e.category.name == categoryFilter.name;
      }).toList();
    }

    if (paymentFilter != PaymentType.all) {
      result = result.where((e) {
        return e.paymentMethod.name == paymentFilter.name;
      }).toList();
    }

    if (searchQuery.isNotEmpty) {
      result = result.where((e) {
        final title = e.title.toLowerCase();
        final amount = e.amount.toString();
        final category = e.category.toString();
        final paymentType = e.paymentMethod.toString();
        return title.contains(searchQuery) ||
            amount.contains(searchQuery) ||
            category.contains(searchQuery) ||
            paymentType.contains(searchQuery);
      }).toList();
    }

    filteredExpenses = result;

    emit(ExpenseLoaded(filteredExpenses));
  }

  void clearFilter() {
    selectedDateFilter = DateFilter.all;
    selectedTypeFilter = TypeFilter.all;
    selectedPaymentFilter = PaymentType.all;
    selectedCategoryFilter = CategoryFilter.all;

    filteredExpenses = allExpenses;

    emit(ExpenseLoaded(filteredExpenses));
  }
}
