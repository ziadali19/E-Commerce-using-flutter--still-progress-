// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:e_commerce/features/favorite/data/repository/favorite_repository.dart';
import 'package:e_commerce/features/home/data/model/product_details_model.dart';
import 'package:e_commerce/core/network/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:e_commerce/features/search/data/repository/search_repository.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../favorite/controller/cubit/favorite_cubit.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final BaseSearchRepository baseSearchRepository;
  final BaseFavoriteRepository baseFavoriteRepository;
  SearchCubit(this.baseSearchRepository, this.baseFavoriteRepository)
      : super(SearchInitial());
  TextEditingController searchController = TextEditingController();
  static SearchCubit get(BuildContext context) {
    return BlocProvider.of(context);
  }

  int searchPageNumber = 1;
  List<ProductsDataModel> searchList = [];
  Map<String, bool> favSearchValues = {};
  searchProducts(dynamic keyWord, int pageNumber) async {
    pageNumber = 1;
    emit(SearchProductsLoading());
    Either<Failure, List<ProductsDataModel>> result =
        await baseSearchRepository.searchProducts(keyWord, pageNumber);
    result.fold((l) {
      emit(SearchProductsError(l.message));
    }, (r) {
      searchList = r;
      searchList.forEach((element) {
        favSearchValues
            .addAll({element.productId.toString(): element.favorite});
      });
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

  addOrRemoveFromFavSearch(
      int productId, String token, BuildContext context) async {
    favSearchValues[productId.toString()] =
        !favSearchValues[productId.toString()]!;
    emit(AddOrRemoveFavSearchLoading());
    Either<Failure, List<ProductsDataModel>> result =
        await baseFavoriteRepository.addOrRemoveFromFavorite(productId, token);
    result.fold((l) {
      favSearchValues[productId.toString()] =
          !favSearchValues[productId.toString()]!;
      emit(AddOrRemoveFavSearchError(l.message));
    }, (r) {
      FavoriteCubit.get(context).favList = r;
      for (var element in FavoriteCubit.get(context).favList) {
        FavoriteCubit.get(context)
            .favValues
            .addAll({element.productId.toString(): element.favorite});
      }
      FavoriteCubit.get(context).updateFavList();
      emit(AddOrRemoveFavSearchSuccess());
    });
  }
}
