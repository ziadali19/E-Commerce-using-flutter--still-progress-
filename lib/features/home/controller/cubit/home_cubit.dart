import 'package:bloc/bloc.dart';
import 'package:e_commerce/features/favorite/controller/cubit/favorite_cubit.dart';
import 'package:e_commerce/features/home/data/model/active_user_model.dart';
import 'package:e_commerce/core/network/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:e_commerce/features/home/data/model/categories_model.dart';
import 'package:e_commerce/features/home/data/model/home_products_model.dart';
import 'package:e_commerce/features/home/data/model/product_details_model.dart';
import 'package:e_commerce/features/home/data/repository/home_repository.dart';
import 'package:e_commerce/features/home/presentation/layouts/home_layout_screen.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../favorite/data/repository/favorite_repository.dart';
import '../../presentation/screens/home_screen.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.homeBaseRepository, this.baseFavoriteRepository)
      : super(HomeInitial());
  final HomeBaseRepository homeBaseRepository;
  final BaseFavoriteRepository baseFavoriteRepository;
  static HomeCubit get(context) {
    return BlocProvider.of(context);
  }

//getActiveUserData
  ActiveUserModel? userModel;
  getActiveUserData(token) async {
    emit(HomeGetActiveUserDataLoading());
    Either<Failure, ActiveUserModel> result =
        await homeBaseRepository.getActiveUserData(token);
    result.fold((l) {
      emit(HomeGetActiveUserDataError(l.message));
    }, (r) {
      userModel = r;
      emit(HomeGetActiveUserDataSuccess());
    });
  }

//get products
  Map<String, bool> favTrendingValues = {};
  Map<String, bool> favNewArrivalValues = {};
  Map<String, bool> favBestOffersValues = {};
  Map<String, bool> favBestSellerValues = {};
  Map<String, bool> favTopRatedValues = {};
  HomeProductsModel? homeProductsModel;

  getHomeProducts() async {
    emit(HomeGetProductsLoading());
    Either<Failure, HomeProductsModel> result =
        await homeBaseRepository.getHomeProducts();
    result.fold((l) {
      emit(HomeGetProductsError(l.message));
    }, (r) {
      homeProductsModel = r;
      homeProductsModel!.trending.forEach((element) {
        favTrendingValues
            .addAll({element.productId.toString(): element.favorite});
      });
      homeProductsModel!.bestOffers.forEach((element) {
        favBestOffersValues
            .addAll({element.productId.toString(): element.favorite});
      });
      homeProductsModel!.bestSeller.forEach((element) {
        favBestSellerValues
            .addAll({element.productId.toString(): element.favorite});
      });
      homeProductsModel!.topRated.forEach((element) {
        favTopRatedValues
            .addAll({element.productId.toString(): element.favorite});
      });
      homeProductsModel!.newArrival.forEach((element) {
        favNewArrivalValues
            .addAll({element.productId.toString(): element.favorite});
      });

      emit(HomeGetProductsSuccess());
    });
  }

  //get categories
  List<CategoriesDataModel> categories = [];
  getCategories() async {
    emit(HomeGetCategoriesLoading());
    Either<Failure, List<CategoriesDataModel>> result =
        await homeBaseRepository.getCategories();
    result.fold((l) {
      emit(HomeGetCategoriesError(l.message));
    }, (r) {
      categories = r;
      emit(HomeGetCategoriesSuccess());
    });
  }

  addOrRemoveFromFavHomePage(
      int productId, String token, BuildContext context) async {
    if (favTrendingValues.keys.contains(productId.toString())) {
      favTrendingValues[productId.toString()] =
          !favTrendingValues[productId.toString()]!;
    }

    if (favBestOffersValues.keys.contains(productId.toString())) {
      favBestOffersValues[productId.toString()] =
          !favBestOffersValues[productId.toString()]!;
    }
    if (favBestSellerValues.keys.contains(productId.toString())) {
      favBestSellerValues[productId.toString()] =
          !favBestSellerValues[productId.toString()]!;
    }
    if (favTopRatedValues.keys.contains(productId.toString())) {
      favTopRatedValues[productId.toString()] =
          !favTopRatedValues[productId.toString()]!;
    }
    if (favNewArrivalValues.keys.contains(productId.toString())) {
      favNewArrivalValues[productId.toString()] =
          !favNewArrivalValues[productId.toString()]!;
    }

    emit(AddOrRemoveFavHomePageLoading());
    Either<Failure, List<ProductsDataModel>> result =
        await baseFavoriteRepository.addOrRemoveFromFavorite(productId, token);
    result.fold((l) {
      if (favTrendingValues.keys.contains(productId.toString())) {
        favTrendingValues[productId.toString()] =
            !favTrendingValues[productId.toString()]!;
      }

      if (favBestOffersValues.keys.contains(productId.toString())) {
        favBestOffersValues[productId.toString()] =
            !favBestOffersValues[productId.toString()]!;
      }
      if (favBestSellerValues.keys.contains(productId.toString())) {
        favBestSellerValues[productId.toString()] =
            !favBestSellerValues[productId.toString()]!;
      }
      if (favTopRatedValues.keys.contains(productId.toString())) {
        favTopRatedValues[productId.toString()] =
            !favTopRatedValues[productId.toString()]!;
      }
      if (favNewArrivalValues.keys.contains(productId.toString())) {
        favNewArrivalValues[productId.toString()] =
            !favNewArrivalValues[productId.toString()]!;
      }
      emit(AddOrRemoveFavHomePageError(l.message));
    }, (r) {
      /* FavoriteCubit.get(context).favList = r;
      for (var element in FavoriteCubit.get(context).favList) {
        FavoriteCubit.get(context)
            .favValues
            .addAll({element.productId.toString(): element.favorite});
      }
      FavoriteCubit.get(context).updateFavList();*/
      emit(AddOrRemoveFavHomePageSuccess());
    });
  }
}
