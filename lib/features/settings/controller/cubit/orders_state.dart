part of 'orders_cubit.dart';

abstract class OrdersState {}

class OrdersInitial extends OrdersState {}

class GetOrdersLoading extends OrdersState {}

class GetOrdersSuccess extends OrdersState {}

class GetOrdersError extends OrdersState {
  final String? errorMsg;

  GetOrdersError(this.errorMsg);
}
