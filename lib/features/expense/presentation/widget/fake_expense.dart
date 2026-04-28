import '../../../../core/enums/app_enums.dart';
import '../../domain/entity/expense.dart';

class FakeExpense {
  static Expense fake() {
    return Expense(
      id: '',
      title: 'Loading...',
      amount: 0,
      type: TransactionType.expense,
      category: ExpenseCategory.other,
      paymentMethod: PaymentMethod.cash,
      createdAt: DateTime.now(),
    );
  }
}