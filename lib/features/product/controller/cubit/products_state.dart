part of 'products_cubit.dart';

abstract class ProductsState {
  const ProductsState();
}

class ProductsInitial extends ProductsState {}

class GetProductDetailsLoading extends ProductsState {}

class GetProductDetailsSuccess extends ProductsState {}

class GetProductDetailsError extends ProductsState {
  final String? error;

  const GetProductDetailsError(this.error);
}

class ChangeIndicatorIndex extends ProductsState {}

class AddToCartLoading extends ProductsState {}

class AddToCartSuccess extends ProductsState {
  final String? successMsg;

  const AddToCartSuccess(this.successMsg);
}

class AddToCartError extends ProductsState {
  final String? error;

  const AddToCartError(this.error);
}

class EnableLoading extends ProductsState {}

class DisableLoading extends ProductsState {}
