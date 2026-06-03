import 'package:expenseo/features/saving/domain/entity/deposit.dart';

abstract class DepositState {}

final class DepositInitial extends DepositState {}

final class DepositLoading extends DepositState {}

final class DepositError extends DepositState {
  final String message;
  DepositError(this.message);
}

final class DepositLoaded extends DepositState {
  final List<Deposit> deposits;
  DepositLoaded(this.deposits);
}
