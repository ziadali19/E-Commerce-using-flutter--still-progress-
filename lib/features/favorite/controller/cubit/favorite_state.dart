part of 'favorite_cubit.dart';

abstract class FavoriteState {
  const FavoriteState();
}

class FavoriteInitial extends FavoriteState {}

class AddOrRemoveFavLoading extends FavoriteState {}

class AddOrRemoveFavSuccess extends FavoriteState {}

class AddOrRemoveFavError extends FavoriteState {
  final String? errorMsg;

  AddOrRemoveFavError(this.errorMsg);
}

class GetFavProductsLoading extends FavoriteState {}

class GetFavProductsSuccess extends FavoriteState {}

class GetFavProductsError extends FavoriteState {
  final String? errorMsg;

  GetFavProductsError(this.errorMsg);
}

class ChangeFavIcon extends FavoriteState {}

class NoMoreData extends FavoriteState {}

class ShowLoading extends FavoriteState {}
