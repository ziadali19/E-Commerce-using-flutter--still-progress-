import 'package:dartz/dartz.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/network/failure.dart';

import '../../../favorite/controller/cubit/favorite_cubit.dart';
import '../../../favorite/data/repository/favorite_repository.dart';
import '../../../home/data/model/product_details_model.dart';
import '../../data/models/sub_category_details_model.dart';
import '../../data/repository/category_repository.dart';

part 'sub_categories_details_state.dart';

class SubCategoriesDetailsCubit extends Cubit<SubCategoriesDetailsState> {
  SubCategoriesDetailsCubit(
      this.baseCategoriesRepository, this.baseFavoriteRepository)
      : super(SubCategoriesDetailsInitial());
  final BaseCategoriesRepository baseCategoriesRepository;
  final BaseFavoriteRepository baseFavoriteRepository;
  static SubCategoriesDetailsCubit get(BuildContext context) {
    return BlocProvider.of(context);
  }

  int subCategoryPageNumber = 1;

  //get subcategory details
  SubCategoryDetailsModel? subCategoryDetailsModel;
  String? subCategoryErrorMsg;
  Map<String, bool> subCategoryFavValues = {};
  subCategoryDetails(int id, int pageNumber) async {
    pageNumber = 1;
    subCategoryDetailsModel = null;
    emit(GetSubCategoryDetailLoading());
    Either<Failure, SubCategoryDetailsModel> result =
        await baseCategoriesRepository.subCategoryDetails(id, pageNumber);
    result.fold((l) {
      emit(GetSubCategoryDetailError(l.message));
    }, (r) {
      subCategoryDetailsModel = r;
      for (var element in subCategoryDetailsModel!.products) {
        subCategoryFavValues
            .addAll({element.productId.toString(): element.favorite});
      }
      emit(GetSubCategoryDetailSuccess());
    });
  }

  addOrRemoveFromFavoriteSubCategoryDetails(
      int productId, String token, BuildContext context) async {
    subCategoryFavValues[productId.toString()] =
        !subCategoryFavValues[productId.toString()]!;
    emit(AddOrRemoveFavSubCategoryDetailsLoading());
    Either<Failure, List<ProductsDataModel>> result =
        await baseFavoriteRepository.addOrRemoveFromFavorite(productId, token);
    result.fold((l) {
      subCategoryFavValues[productId.toString()] =
          !subCategoryFavValues[productId.toString()]!;
      emit(AddOrRemoveFavSubCategoryDetailsError(l.message));
    }, (r) {
      FavoriteCubit.get(context).favList = r;
      for (var element in FavoriteCubit.get(context).favList) {
        FavoriteCubit.get(context)
            .favValues
            .addAll({element.productId.toString(): element.favorite});
      }
      FavoriteCubit.get(context).updateFavList();
      emit(AddOrRemoveFavSubCategoryDetailsSuccess());
    });
  }

  //for Subcategory details more data
  subCategoryMoreData({required int id}) async {
    subCategoryPageNumber += 1;
    Either<Failure, SubCategoryDetailsModel> result =
        await baseCategoriesRepository.subCategoryDetails(
            id, subCategoryPageNumber);
    result.fold((l) {
      emit(GetSubCategoryDetailError(l.message));
    }, (r) {
      if (r.products.isNotEmpty) {
        subCategoryDetailsModel?.products.addAll(r.products);
        for (var element in r.products) {
          subCategoryFavValues
              .addAll({element.productId.toString(): element.favorite});
        }
        emit(GetSubCategoryDetailSuccess());
      } else {
        subCategoryPageNumber = 1;
      }
    });
  }
}
