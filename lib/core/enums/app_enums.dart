
enum ExpenseCategory {
  food,
  shopping,
  transport,
  health,
  entertainment,
  salary,
  rent,
  other;

  String get key => name;

  String get label => switch (this) {
    food          => 'Food',
    shopping      => 'Shopping',
    transport     => 'Transport',
    health        => 'Health',
    entertainment => 'Entertainment',
    salary        => 'Salary',
    rent          => 'Rent',
    other         => 'Other',
  };
}

enum PaymentMethod {
  cash, upi, card, netbanking;

  String get key   => name;
  String get label => switch (this) {
    cash       => 'Cash',
    upi        => 'UPI',
    card       => 'Card',
    netbanking => 'Net Banking',
  };
}

enum TransactionType {
  income, expense;

  String get key   => name;

  String get label => switch (this) {
    income => 'Income',
    expense => 'Expense',
  };
}
