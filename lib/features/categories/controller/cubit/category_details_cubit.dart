import 'package:dartz/dartz.dart';
import 'package:e_commerce/features/favorite/controller/cubit/favorite_cubit.dart';
import 'package:e_commerce/features/favorite/data/repository/favorite_repository.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/network/failure.dart';

import '../../../home/data/model/product_details_model.dart';
import '../../data/models/category_details_model.dart';

import '../../data/repository/category_repository.dart';

part 'category_details_state.dart';

class CategoryDetailsCubit extends Cubit<CategoryDetailsState> {
  final BaseCategoriesRepository baseCategoriesRepository;
  final BaseFavoriteRepository baseFavoriteRepository;

  CategoryDetailsCubit(
      this.baseCategoriesRepository, this.baseFavoriteRepository)
      : super(CategoryDetailsInitial());
  static CategoryDetailsCubit get(context) {
    return BlocProvider.of(context);
  }

  int categoryDetailspageNumber = 1;

  //get category details
  CategoryDetailsModel? categoryDetailsModel;
  String? errorMsg;
  Map<String, bool> favValues = {};
  categoryDetails(int id, int pageNumber) async {
    pageNumber = 1;
    categoryDetailsModel = null;

    emit(GetCategoryDetailLoading());
    Either<Failure, CategoryDetailsModel> result =
        await baseCategoriesRepository.categoryDetails(id, pageNumber);
    result.fold((l) {
      emit(GetCategoryDetailError(l.message));
    }, (r) {
      categoryDetailsModel = r;
      for (var e in categoryDetailsModel!.products) {
        favValues.addAll({e.productId.toString(): e.favorite});
      }

      emit(GetCategoryDetailSuccess());
    });
  }

  addOrRemoveFromFavoriteCategoryDetails(
      int productId, String token, BuildContext context) async {
    favValues[productId.toString()] = !favValues[productId.toString()]!;
    emit(AddOrRemoveFavCategoryDetailsLoading());
    Either<Failure, List<ProductsDataModel>> result =
        await baseFavoriteRepository.addOrRemoveFromFavorite(productId, token);
    result.fold((l) {
      favValues[productId.toString()] = !favValues[productId.toString()]!;
      emit(AddOrRemoveFavCategoryDetailsError(l.message));
    }, (r) {
      FavoriteCubit.get(context).favList = r;
      for (var element in FavoriteCubit.get(context).favList) {
        FavoriteCubit.get(context)
            .favValues
            .addAll({element.productId.toString(): element.favorite});
      }
      FavoriteCubit.get(context).updateFavList();
      emit(AddOrRemoveFavCategoryDetailsSuccess());
    });
  }

// for category more data
  categoryMoreData({required int id}) async {
    categoryDetailspageNumber += 1;
    Either<Failure, CategoryDetailsModel> result =
        await baseCategoriesRepository.categoryDetails(
            id, categoryDetailspageNumber);
    result.fold((l) {
      emit(GetCategoryDetailError(l.message));
    }, (r) {
      if (r.products.isNotEmpty) {
        categoryDetailsModel?.products.addAll(r.products);
        for (var e in r.products) {
          favValues.addAll({e.productId.toString(): e.favorite});
        }
        emit(GetCategoryDetailSuccess());
      } else {
        categoryDetailspageNumber = 1;
      }
    });
  }
}
