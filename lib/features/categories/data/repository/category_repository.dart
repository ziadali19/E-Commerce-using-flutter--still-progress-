import 'package:dartz/dartz.dart';
import 'package:e_commerce/core/network/failure.dart';
import 'package:e_commerce/features/categories/data/remote_data_source/category_remote_data_source.dart';

import '../../../../core/network/network_exception.dart';
import '../../../home/data/model/categories_model.dart';
import '../../../home/data/model/product_details_model.dart';
import '../models/brand_main_info_model.dart';
import '../models/category_details_model.dart';
import '../models/sub_category_details_model.dart';
import '../models/sub_category_main_info_model.dart';

abstract class BaseCategoriesRepository {
  Future<Either<Failure, CategoryDetailsModel>> categoryDetails(
      int id, int pageNumber);
  Future<Either<Failure, List<CategoriesDataModel>>> getCategories();
  Future<Either<Failure, List<SubCategoryMainInfoModel>>> getSubCategories();
  Future<Either<Failure, List<BrandMainInfoModel>>> getBrands();
  Future<Either<Failure, SubCategoryDetailsModel>> subCategoryDetails(
      int id, int pageNumber);
  Future<Either<Failure, Brands>> brandDetails(int id, int pageNumber);
  Future<Either<Failure, List<ProductsDataModel>>> filterProducts(
      {required int categoryId,
      required String? subCategory,
      required int? subCategoryId,
      required String? brand,
      required int? brandId,
      required String? discount,
      required int? discountPercentage,
      required String? price,
      required List? priceRange,
      required String? orderByPrice,
      required String? orderByPriceValue,
      required String? rating,
      required int? ratingValue});
}

class CategoriesRepository extends BaseCategoriesRepository {
  final BaseCategoryRemoteDataSource baseCategoryRemoteDataSource;

  CategoriesRepository(this.baseCategoryRemoteDataSource);
  @override
  Future<Either<Failure, CategoryDetailsModel>> categoryDetails(
      int id, int pageNumber) async {
    try {
      return right(
          await baseCategoryRemoteDataSource.categoryDetails(id, pageNumber));
    } on NetworkException catch (e) {
      return left(NetworkFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<CategoriesDataModel>>> getCategories() async {
    try {
      List<CategoriesDataModel> res =
          await baseCategoryRemoteDataSource.getCategories();
      return right(res);
    } on NetworkException catch (e) {
      return left(NetworkFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, SubCategoryDetailsModel>> subCategoryDetails(
      int id, int pageNumber) async {
    try {
      return right(await baseCategoryRemoteDataSource.subCategoryDetails(
          id, pageNumber));
    } on NetworkException catch (e) {
      return left(NetworkFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, Brands>> brandDetails(int id, int pageNumber) async {
    try {
      return right(
          await baseCategoryRemoteDataSource.brandDetails(id, pageNumber));
    } on NetworkException catch (e) {
      return left(NetworkFailure(e.message));
    }
  }

  /////////filter
  @override
  Future<Either<Failure, List<ProductsDataModel>>> filterProducts(
      {required int categoryId,
      required String? subCategory,
      required int? subCategoryId,
      required String? brand,
      required int? brandId,
      required String? discount,
      required int? discountPercentage,
      required String? price,
      required List? priceRange,
      required String? orderByPrice,
      required String? orderByPriceValue,
      required String? rating,
      required int? ratingValue}) async {
    try {
      List<ProductsDataModel> result =
          await baseCategoryRemoteDataSource.filterProducts(
              categoryId: categoryId,
              subCategory: subCategory,
              subCategoryId: subCategoryId,
              brand: brand,
              brandId: brandId,
              discount: discount,
              discountPercentage: discountPercentage,
              price: price,
              priceRange: priceRange,
              orderByPrice: orderByPrice,
              orderByPriceValue: orderByPriceValue,
              rating: rating,
              ratingValue: ratingValue);

      return right(result);
    } on NetworkException catch (e) {
      return left(NetworkFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<SubCategoryMainInfoModel>>>
      getSubCategories() async {
    try {
      List<SubCategoryMainInfoModel> res =
          await baseCategoryRemoteDataSource.getSubCategories();
      return right(res);
    } on NetworkException catch (e) {
      return left(NetworkFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<BrandMainInfoModel>>> getBrands() async {
    try {
      List<BrandMainInfoModel> res =
          await baseCategoryRemoteDataSource.getBrands();
      return right(res);
    } on NetworkException catch (e) {
      return left(NetworkFailure(e.message));
    }
  }
}
