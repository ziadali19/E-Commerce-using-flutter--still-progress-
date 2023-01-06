part of 'search_cubit.dart';

abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchProductsLoading extends SearchState {}

class SearchProductsSuccess extends SearchState {}

class SearchProductsError extends SearchState {
  final String? errorMsg;

  SearchProductsError(this.errorMsg);
}
