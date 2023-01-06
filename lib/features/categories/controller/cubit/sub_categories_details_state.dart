part of 'sub_categories_details_cubit.dart';

abstract class SubCategoriesDetailsState {
  const SubCategoriesDetailsState();
}

class SubCategoriesDetailsInitial extends SubCategoriesDetailsState {}

class GetSubCategoryDetailLoading extends SubCategoriesDetailsState {}

class GetSubCategoryDetailSuccess extends SubCategoriesDetailsState {}

class GetSubCategoryDetailError extends SubCategoriesDetailsState {
  final String? error;

  const GetSubCategoryDetailError(this.error);
}

class AddOrRemoveFavSubCategoryDetailsLoading
    extends SubCategoriesDetailsState {}

class AddOrRemoveFavSubCategoryDetailsSuccess
    extends SubCategoriesDetailsState {}

class AddOrRemoveFavSubCategoryDetailsError extends SubCategoriesDetailsState {
  final String? errorMsg;

  AddOrRemoveFavSubCategoryDetailsError(this.errorMsg);
}
