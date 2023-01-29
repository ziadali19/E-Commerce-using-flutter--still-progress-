import 'package:e_commerce/core/network/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:e_commerce/features/categories/data/models/sub_category_main_info_model.dart';
import 'package:e_commerce/features/categories/data/repository/category_repository.dart';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../home/data/model/categories_model.dart';
import '../../data/models/brand_main_info_model.dart';

part 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  final BaseCategoriesRepository baseCategoriesRepository;
  CategoriesCubit(this.baseCategoriesRepository) : super(CategoriesInitial());
  static CategoriesCubit get(BuildContext context) {
    return BlocProvider.of(context);
  }

  //get categories
  List<CategoriesDataModel> categoriesList = [];
  getCategories() async {
    emit(GetCategoryLoading());
    Either<Failure, List<CategoriesDataModel>> result =
        await baseCategoriesRepository.getCategories();
    result.fold((l) {
      emit(GetCategoryError(l.message));
    }, (r) {
      categoriesList = r;
      emit(GetCategorySuccess());
    });
  }

  List<SubCategoryMainInfoModel> subCategoriesList = [];
  getSubCategories() async {
    emit(GetSubCategoryLoading());
    Either<Failure, List<SubCategoryMainInfoModel>> result =
        await baseCategoriesRepository.getSubCategories();
    result.fold((l) {
      emit(GetSubCategoryError(l.message));
    }, (r) {
      subCategoriesList = r;
      emit(GetSubCategorySuccess());
    });
  }

  List<BrandMainInfoModel> brandsList = [];
  getBrands() async {
    emit(GetBrandLoading());
    Either<Failure, List<BrandMainInfoModel>> result =
        await baseCategoriesRepository.getBrands();
    result.fold((l) {
      emit(GetBrandError(l.message));
    }, (r) {
      brandsList = r;
      emit(GetBrandSuccess());
    });
  }
}
