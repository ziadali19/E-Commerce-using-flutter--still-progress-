part of 'category_details_cubit.dart';

abstract class CategoryDetailsState {
  const CategoryDetailsState();
}

class CategoryDetailsInitial extends CategoryDetailsState {}

class GetCategoryDetailLoading extends CategoryDetailsState {}

class GetCategoryDetailSuccess extends CategoryDetailsState {}

class GetCategoryDetailError extends CategoryDetailsState {
  final String? error;

  const GetCategoryDetailError(this.error);
}

class NoMoreDataForCategoryDetails extends CategoryDetailsState {}

class ShowLoadingForCategoryDetails extends CategoryDetailsState {}

class NoMoreDataForSbCategoryDetails extends CategoryDetailsState {}

class ShowLoadingForSubCategoryDetails extends CategoryDetailsState {}

class AddOrRemoveFavCategoryDetailsLoading extends CategoryDetailsState {}

class AddOrRemoveFavCategoryDetailsSuccess extends CategoryDetailsState {}

class AddOrRemoveFavCategoryDetailsError extends CategoryDetailsState {
  final String? errorMsg;

  AddOrRemoveFavCategoryDetailsError(this.errorMsg);
}
