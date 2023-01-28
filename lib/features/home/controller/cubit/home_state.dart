part of 'home_cubit.dart';

abstract class HomeState {
  const HomeState();
}

class HomeInitial extends HomeState {}

class HomeGetActiveUserDataLoading extends HomeState {}

class HomeGetActiveUserDataSuccess extends HomeState {}

class HomeGetActiveUserDataError extends HomeState {
  final String? error;

  const HomeGetActiveUserDataError(this.error);
}

class HomeGetProductsLoading extends HomeState {}

class HomeGetProductsSuccess extends HomeState {}

class HomeGetProductsError extends HomeState {
  final String? error;

  const HomeGetProductsError(this.error);
}

class HomeGetCategoriesLoading extends HomeState {}

class HomeGetCategoriesSuccess extends HomeState {}

class HomeGetCategoriesError extends HomeState {
  final String? error;

  const HomeGetCategoriesError(this.error);
}

class AddOrRemoveFavHomePageLoading extends HomeState {}

class AddOrRemoveFavHomePageSuccess extends HomeState {}

class AddOrRemoveFavHomePageError extends HomeState {
  final String? errorMsg;

  AddOrRemoveFavHomePageError(this.errorMsg);
}
