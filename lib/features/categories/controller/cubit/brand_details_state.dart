part of 'brand_details_cubit.dart';

abstract class BrandDetailsState {
  const BrandDetailsState();
}

class BrandDetailsInitial extends BrandDetailsState {}

class AddOrRemoveFavBrandLoading extends BrandDetailsState {}

class AddOrRemoveFavBrandSuccess extends BrandDetailsState {}

class AddOrRemoveFavBrandError extends BrandDetailsState {
  final String? errorMsg;

  AddOrRemoveFavBrandError(this.errorMsg);
}

class GetBrandDetailLoading extends BrandDetailsState {}

class GetBrandDetailSuccess extends BrandDetailsState {}

class GetBrandDetailError extends BrandDetailsState {
  final String? error;

  const GetBrandDetailError(this.error);
}
