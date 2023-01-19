part of 'filter_cubit.dart';

abstract class FilterState {
  const FilterState();
}

class FilterInitial extends FilterState {}

class GetFilteredListLoading extends FilterState {}

class GetFilteredListSuccess extends FilterState {}

class GetFilteredListError extends FilterState {
  final String? errorMessage;

  GetFilteredListError(this.errorMessage);
}

class ChangeCategoryCardColor extends FilterState {}

class ChangeSubCategoryCardColor extends FilterState {}

class ChangeBrandCardColor extends FilterState {}

class ChangeOrderByPriceCardColor extends FilterState {}

class ChangeSliderValue extends FilterState {}

class ResetFilters extends FilterState {}

class GetCategoryLoading extends FilterState {}

class GetCategorySuccess extends FilterState {}

class GetCategoryError extends FilterState {
  final String? error;

  const GetCategoryError(this.error);
}

class GetCategoryDetailLoading extends FilterState {}

class GetCategoryDetailSuccess extends FilterState {}

class GetCategoryDetailError extends FilterState {
  final String? error;

  const GetCategoryDetailError(this.error);
}

class GetSubCategoryDetailLoading extends FilterState {}

class GetSubCategoryDetailSuccess extends FilterState {}

class GetSubCategoryDetailError extends FilterState {
  final String? error;

  const GetSubCategoryDetailError(this.error);
}

class SubCategoryAndBrandVisibile extends FilterState {}

class AddOrRemoveFavFilterLoading extends FilterState {}

class AddOrRemoveFavFilterSuccess extends FilterState {}

class AddOrRemoveFavFilterError extends FilterState {
  final String? errorMsg;

  AddOrRemoveFavFilterError(this.errorMsg);
}
