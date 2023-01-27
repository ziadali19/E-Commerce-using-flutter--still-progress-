part of 'payments_cubit.dart';

abstract class PaymentsState {
  const PaymentsState();
}

class PaymentsInitial extends PaymentsState {}

class ChangeGroupValue extends PaymentsState {}

class UpdateAddress extends PaymentsState {}

class MakeCheckoutLoading extends PaymentsState {}

class MakeCheckoutSuccess extends PaymentsState {}

class MakeCheckoutError extends PaymentsState {
  final String? errorMsg;

  MakeCheckoutError(this.errorMsg);
}

class GetFirstTokenLoading extends PaymentsState {}

class GetFirstTokenSuccess extends PaymentsState {}

class GetFirstTokenError extends PaymentsState {
  final String? errorMsg;

  GetFirstTokenError(this.errorMsg);
}

class GetFinalTokenLoading extends PaymentsState {}

class GetFinalTokenSuccess extends PaymentsState {}

class GetFinalTokenError extends PaymentsState {
  final String? errorMsg;

  GetFinalTokenError(this.errorMsg);
}

class GetOrderIdTokenLoading extends PaymentsState {}

class GetOrderIdTokenSuccess extends PaymentsState {}

class GetOrderIdTokenError extends PaymentsState {
  final String? errorMsg;

  GetOrderIdTokenError(this.errorMsg);
}
