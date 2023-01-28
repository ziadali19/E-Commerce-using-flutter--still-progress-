import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:e_commerce/features/favorite/data/repository/favorite_repository.dart';
import 'package:e_commerce/features/filter/data/repository/filter_repository.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/network/failure.dart';
import '../../../../core/services/service_locator.dart';
import '../../../categories/data/models/category_details_model.dart';
import '../../../categories/data/models/sub_category_details_model.dart';
import '../../../favorite/controller/cubit/favorite_cubit.dart';
import '../../../home/data/model/categories_model.dart';
import '../../../home/data/model/product_details_model.dart';

part 'filter_state.dart';

class FilterCubit extends Cubit<FilterState> {
  FilterCubit(this.baseFilterRepository, this.baseFavoriteRepository)
      : super(FilterInitial());
  final BaseFilterRepository baseFilterRepository;
  final BaseFavoriteRepository baseFavoriteRepository;
  static FilterCubit get(BuildContext context) {
    return BlocProvider.of(context);
  }

  Map<String, bool> filterFavValues = {};
  int filterPageNumber = 1;

//get subcategory details
  SubCategoryDetailsModel? subCategoryDetailsModel;
  bool isLoading = false;
  subCategoryDetails(int id) async {
    subCategoryDetailsModel = null;
    isLoading = true;
    //emit(GetSubCategoryDetailLoading());
    Either<Failure, SubCategoryDetailsModel> result =
        await baseFilterRepository.subCategoryDetails(id);
    result.fold((l) {
      isLoading = false;
      emit(GetSubCategoryDetailError(l.message));
    }, (r) {
      subCategoryDetailsModel = r;
      isLoading = false;
      emit(GetSubCategoryDetailSuccess());
    });
  }

//get category details
  CategoryDetailsModel? categoryDetailsModel;

  categoryDetails(int id) async {
    categoryDetailsModel = null;

    emit(GetCategoryDetailLoading());
    Either<Failure, CategoryDetailsModel> result =
        await baseFilterRepository.categoryDetails(id);
    result.fold((l) {
      emit(GetCategoryDetailError(l.message));
    }, (r) {
      categoryDetailsModel = r;

      emit(GetCategoryDetailSuccess());
    });
  }

//get categories
  List<CategoriesDataModel> categoriesList = [];
  getCategories() async {
    emit(GetCategoryLoading());
    Either<Failure, List<CategoriesDataModel>> result =
        await baseFilterRepository.getCategories();
    result.fold((l) {
      emit(GetCategoryError(l.message));
    }, (r) {
      categoriesList = r;
      emit(GetCategorySuccess());
    });
  }

  ////////filter
  List<ProductsDataModel> filteredList = [];
  filterProducts({
    required dynamic categoryId,
    required String? subCategory,
    required dynamic subCategoryId,
    required String? brand,
    required dynamic brandId,
    required String? discount,
    required dynamic discountPercentage,
    required String? priceFrom,
    required String? priceTo,
    required dynamic startPrice,
    required dynamic endPrice,
    required String? orderByPrice,
    required dynamic orderByPriceValue,
    required String? rating,
    required dynamic ratingValue,
  }) async {
    emit(GetFilteredListLoading());
    Either<Failure, List<ProductsDataModel>> result =
        await baseFilterRepository.filterProducts(
            categoryId: categoryId,
            subCategory: subCategory,
            subCategoryId: subCategoryId,
            brand: brand,
            brandId: brandId,
            discount: discount,
            discountPercentage: discountPercentage,
            priceFrom: priceFrom,
            priceTo: priceTo,
            startPrice: startPrice,
            endPrice: endPrice,
            orderByPrice: orderByPrice,
            orderByPriceValue: orderByPriceValue,
            rating: rating,
            ratingValue: ratingValue,
            pageNumber: 1);

    result.fold((l) {
      emit(GetFilteredListError(l.message));
    }, (r) {
      filteredList = r;
      for (var element in filteredList) {
        filterFavValues
            .addAll({element.productId.toString(): element.favorite});
      }
      emit(GetFilteredListSuccess());
    });
  }

  bool categoryClicked = false;
  changeCategoryCardColor() {
    categoryClicked = true;
    emit(ChangeCategoryCardColor());
  }

  bool subCategoryClicked = false;
  changeSubCategoryCardColor() {
    subCategoryClicked = true;
    emit(ChangeSubCategoryCardColor());
  }

  bool brandClicked = false;
  changeBrandCardColor() {
    brandClicked = true;
    emit(ChangeBrandCardColor());
  }

  double startPrice = 1;
  double endPrice = 5000;
  sliderValu(RangeValues value) {
    startPrice = value.start;
    endPrice = value.end;
    emit(ChangeSliderValue());
  }

  List orderByPrice = ['Low to High', 'High to Low'];
  bool orderByPriceClicked = false;
  changeOrderByPriceCardColor() {
    orderByPriceClicked = true;
    emit(ChangeOrderByPriceCardColor());
  }

  resetFilters() {
    brandClicked = false;
    subCategoryClicked = false;
    orderByPriceClicked = false;
    endPrice = 5000;
    startPrice = 1;
    filteredList = [];
    isSubCategoryVisible = false;
    subCategoryDetailsModel = null;
    filterPageNumber = 1;
    emit(ResetFilters());
  }

  bool isSubCategoryVisible = false;
  subCategoryVisibilty() {
    isSubCategoryVisible = true;
    emit(SubCategoryAndBrandVisibile());
  }

  addOrRemoveFromFavFilter(
      int productId, String token, BuildContext context) async {
    filterFavValues[productId.toString()] =
        !filterFavValues[productId.toString()]!;
    emit(AddOrRemoveFavFilterLoading());
    Either<Failure, List<ProductsDataModel>> result =
        await baseFavoriteRepository.addOrRemoveFromFavorite(productId, token);
    result.fold((l) {
      filterFavValues[productId.toString()] =
          !filterFavValues[productId.toString()]!;
      emit(AddOrRemoveFavFilterError(l.message));
    }, (r) {
      FavoriteCubit.get(context).favList = r;
      for (var element in FavoriteCubit.get(context).favList) {
        FavoriteCubit.get(context)
            .favValues
            .addAll({element.productId.toString(): element.favorite});
      }
      FavoriteCubit.get(context).updateFavList();
      emit(AddOrRemoveFavFilterSuccess());
    });
  }

  filterLoadMore({
    required dynamic categoryId,
    required String? subCategory,
    required dynamic subCategoryId,
    required String? brand,
    required dynamic brandId,
    required String? discount,
    required dynamic discountPercentage,
    required String? priceFrom,
    required String? priceTo,
    required dynamic startPrice,
    required dynamic endPrice,
    required String? orderByPrice,
    required dynamic orderByPriceValue,
    required String? rating,
    required dynamic ratingValue,
  }) async {
    filterPageNumber += 1;
    Either<Failure, List<ProductsDataModel>> result =
        await baseFilterRepository.filterProducts(
            categoryId: categoryId,
            subCategory: subCategory,
            subCategoryId: subCategoryId,
            brand: brand,
            brandId: brandId,
            discount: discount,
            discountPercentage: discountPercentage,
            priceFrom: priceFrom,
            priceTo: priceTo,
            startPrice: startPrice,
            endPrice: endPrice,
            orderByPrice: orderByPrice,
            orderByPriceValue: orderByPriceValue,
            rating: rating,
            ratingValue: ratingValue,
            pageNumber: filterPageNumber);

    result.fold((l) {
      emit(GetFilteredListError(l.message));
    }, (r) {
      if (r.isNotEmpty) {
        filteredList.addAll(r);
        emit(GetFilteredListSuccess());
      } else {
        filterPageNumber = 1;
      }
    });
  }
}
