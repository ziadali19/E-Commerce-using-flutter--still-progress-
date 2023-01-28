import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:e_commerce/features/categories/data/repository/category_repository.dart';
import 'package:e_commerce/features/favorite/data/repository/favorite_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/network/failure.dart';
import '../../../../core/services/service_locator.dart';
import '../../../favorite/controller/cubit/favorite_cubit.dart';
import '../../../home/data/model/product_details_model.dart';
import '../../data/models/category_details_model.dart';

part 'brand_details_state.dart';

class BrandDetailsCubit extends Cubit<BrandDetailsState> {
  BrandDetailsCubit(this.baseCategoriesRepository, this.baseFavoriteRepository)
      : super(BrandDetailsInitial());
  final BaseCategoriesRepository baseCategoriesRepository;
  final BaseFavoriteRepository baseFavoriteRepository;
  static BrandDetailsCubit get(BuildContext context) {
    return BlocProvider.of(context);
  }

  Map<String, bool> brandFavValues = {};
  int brandPageNumber = 1;
  //get brand details
  Brands? brandDetailsModel;
  String? brandErrorMsg;

  brandDetails(int id, int pageNumber) async {
    pageNumber = 1;
    brandDetailsModel = null;
    emit(GetBrandDetailLoading());
    Either<Failure, Brands> result =
        await baseCategoriesRepository.brandDetails(id, pageNumber);
    result.fold((l) {
      emit(GetBrandDetailError(l.message));
    }, (r) {
      brandDetailsModel = r;
      for (var element in brandDetailsModel!.products) {
        brandFavValues.addAll({element.productId.toString(): element.favorite});
      }
      emit(GetBrandDetailSuccess());
    });
  }

  addOrRemoveFromFavoriteBrandDetails(
      int productId, String token, BuildContext context) async {
    brandFavValues[productId.toString()] =
        !brandFavValues[productId.toString()]!;
    emit(AddOrRemoveFavBrandLoading());
    Either<Failure, List<ProductsDataModel>> result =
        await baseFavoriteRepository.addOrRemoveFromFavorite(productId, token);
    result.fold((l) {
      brandFavValues[productId.toString()] =
          !brandFavValues[productId.toString()]!;
      emit(AddOrRemoveFavBrandError(l.message));
    }, (r) {
      FavoriteCubit.get(context).favList = r;
      for (var element in FavoriteCubit.get(context).favList) {
        FavoriteCubit.get(context)
            .favValues
            .addAll({element.productId.toString(): element.favorite});
      }
      FavoriteCubit.get(context).updateFavList();
      emit(AddOrRemoveFavBrandSuccess());
    });
  }

  //for brand details more data
  brandMoreData({required int id}) async {
    brandPageNumber += 1;
    Either<Failure, Brands> result =
        await baseCategoriesRepository.brandDetails(id, brandPageNumber);
    result.fold((l) {
      emit(GetBrandDetailError(l.message));
    }, (r) {
      if (r.products.isNotEmpty) {
        brandDetailsModel?.products.addAll(r.products);
        for (var element in r.products) {
          brandFavValues
              .addAll({element.productId.toString(): element.favorite});
        }
        emit(GetBrandDetailSuccess());
      } else {
        brandPageNumber = 1;
      }
    });
  }
}
