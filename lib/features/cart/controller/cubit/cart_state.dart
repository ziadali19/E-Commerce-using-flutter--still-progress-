part of 'cart_cubit.dart';

abstract class CartState {}

class CartInitial extends CartState {}

class GetUserCartLoading extends CartState {}

class GetUserCartSuccess extends CartState {}

class GetUserCartError extends CartState {
  final String? error;

  GetUserCartError(this.error);
}

class IncrementItemCount extends CartState {}

class DecrementItemCount extends CartState {}

class UpdateItemAmountLoading extends CartState {}

class UpdateItemAmountSuccess extends CartState {}

class UpdateItemAmountError extends CartState {
  final String? error;

  UpdateItemAmountError(this.error);
}

class DeleteItemFromCartLoading extends CartState {}

class DeleteItemFromCartSuccess extends CartState {}

class DeleteItemFromCartError extends CartState {
  final String? error;

  DeleteItemFromCartError(this.error);
}
