part of 'categories_cubit.dart';

abstract class CategoriesState extends Equatable {
  const CategoriesState();
}

class CategoriesInitial extends CategoriesState {
  @override
  List<Object?> get props => [];
}

class GetCategoryLoading extends CategoriesState {
  @override
  List<Object?> get props => [];
}

class GetCategorySuccess extends CategoriesState {
  @override
  List<Object?> get props => [];
}

class GetCategoryError extends CategoriesState {
  final String? error;

  const GetCategoryError(this.error);
  @override
  List<Object?> get props => [error];
}

class GetSubCategoryLoading extends CategoriesState {
  @override
  List<Object?> get props => [];
}

class GetSubCategorySuccess extends CategoriesState {
  @override
  List<Object?> get props => [];
}

class GetSubCategoryError extends CategoriesState {
  final String? error;

  const GetSubCategoryError(this.error);
  @override
  List<Object?> get props => [error];
}

class GetBrandLoading extends CategoriesState {
  @override
  List<Object?> get props => [];
}

class GetBrandSuccess extends CategoriesState {
  @override
  List<Object?> get props => [];
}

class GetBrandError extends CategoriesState {
  final String? error;

  const GetBrandError(this.error);
  @override
  List<Object?> get props => [error];
}
