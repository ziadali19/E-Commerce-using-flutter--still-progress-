// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:e_commerce/core/network/failure.dart';
import 'package:dartz/dartz.dart';

import 'package:e_commerce/features/favorite/data/repository/favorite_repository.dart';

import 'package:e_commerce/features/home/data/model/product_details_model.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utilis/constants.dart';

part 'favorite_state.dart';

int favPageNumber = 1;

class FavoriteCubit extends Cubit<FavoriteState> {
  final BaseFavoriteRepository baseFavoriteRepository;
  FavoriteCubit(this.baseFavoriteRepository) : super(FavoriteInitial());

  static FavoriteCubit get(BuildContext context) {
    return BlocProvider.of(context);
  }

  addOrRemoveFromFavorite(
      int productId, String token, BuildContext context) async {
    emit(AddOrRemoveFavLoading());
    Either<Failure, List<ProductsDataModel>> result =
        await baseFavoriteRepository.addOrRemoveFromFavorite(productId, token);
    result.fold((l) {
      emit(AddOrRemoveFavError(l.message));
    }, (r) {
      favList = r;
      favList.forEach((element) {
        favValues.addAll({element.productId.toString(): element.favorite});
      });

      emit(AddOrRemoveFavSuccess());
    });
  }

  List<ProductsDataModel> favList = [];
  Map<String, bool> favValues = {};
  getFavorites(String token, int pageNumber) async {
    pageNumber = 1;
    emit(GetFavProductsLoading());
    Either<Failure, List<ProductsDataModel>> result =
        await baseFavoriteRepository.getFavorites(token, pageNumber);

    result.fold((l) {
      emit(GetFavProductsError(l.message));
    }, (r) {
      favList = r;
      favList.forEach((element) {
        favValues.addAll({element.productId.toString(): element.favorite});
      });

      emit(GetFavProductsSuccess());
    });
  }

  loadMore() async {
    favPageNumber += 1;
    Either<Failure, List<ProductsDataModel>> result =
        await baseFavoriteRepository.getFavorites(token!, favPageNumber);

    result.fold((l) {
      emit(GetFavProductsError(l.message));
    }, (r) {
      if (r.isNotEmpty) {
        favList.addAll(r);

        emit(GetFavProductsSuccess());
      } else {
        favPageNumber = 1;
      }
    });
  }

  updateFavList() {
    emit(UpdateFavList());
  }
}
