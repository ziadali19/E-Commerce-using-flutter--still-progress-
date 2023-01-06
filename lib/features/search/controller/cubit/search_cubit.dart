import 'package:bloc/bloc.dart';
import 'package:e_commerce/features/home/data/model/product_details_model.dart';
import 'package:e_commerce/core/network/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:e_commerce/features/search/data/repository/search_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final BaseSearchRepository baseSearchRepository;
  SearchCubit(this.baseSearchRepository) : super(SearchInitial());
  TextEditingController searchController = TextEditingController();
  static SearchCubit get(BuildContext context) {
    return BlocProvider.of(context);
  }

  int searchPageNumber = 1;
  List<ProductsDataModel> searchList = [];
  searchProducts(dynamic keyWord, int pageNumber) async {
    pageNumber = 1;
    emit(SearchProductsLoading());
    Either<Failure, List<ProductsDataModel>> result =
        await baseSearchRepository.searchProducts(keyWord, pageNumber);
    result.fold((l) {
      emit(SearchProductsError(l.message));
    }, (r) {
      searchList = r;
      emit(SearchProductsSuccess());
    });
  }

  searchLoadMore({required dynamic keyWord}) async {
    searchPageNumber += 1;
    Either<Failure, List<ProductsDataModel>> result =
        await baseSearchRepository.searchProducts(keyWord, searchPageNumber);

    result.fold((l) {
      emit(SearchProductsError(l.message));
    }, (r) {
      if (r.isNotEmpty) {
        searchList.addAll(r);
        emit(SearchProductsSuccess());
      } else {
        searchPageNumber = 1;
      }
    });
  }
}
