import 'package:dartz/dartz.dart';
import 'package:e_commerce/core/network/network_exception.dart';
import 'package:e_commerce/features/filter/data/remote_data_source/filter_remote_data_source.dart';

import '../../../../core/network/failure.dart';
import '../../../categories/data/models/category_details_model.dart';
import '../../../categories/data/models/sub_category_details_model.dart';
import '../../../home/data/model/categories_model.dart';
import '../../../home/data/model/product_details_model.dart';

abstract class BaseFilterRepository {
  Future<Either<Failure, SubCategoryDetailsModel>> subCategoryDetails(int id);
  Future<Either<Failure, CategoryDetailsModel>> categoryDetails(int id);
  Future<Either<Failure, List<CategoriesDataModel>>> getCategories();
  Future<Either<Failure, List<ProductsDataModel>>> filterProducts(
      {required dynamic categoryId,
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
      required dynamic ratingValue});
}

class FilterRepository extends BaseFilterRepository {
  final BaseFilterRemoteDataSource baseFilterRemoteDataSource;

  FilterRepository(this.baseFilterRemoteDataSource);
  @override
  Future<Either<Failure, SubCategoryDetailsModel>> subCategoryDetails(
      int id) async {
    try {
      return right(await baseFilterRemoteDataSource.subCategoryDetails(id));
    } on NetworkException catch (e) {
      return left(NetworkFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, CategoryDetailsModel>> categoryDetails(int id) async {
    try {
      return right(await baseFilterRemoteDataSource.categoryDetails(id));
    } on NetworkException catch (e) {
      return left(NetworkFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<ProductsDataModel>>> filterProducts(
      {required dynamic categoryId,
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
      required dynamic ratingValue}) async {
    try {
      List<ProductsDataModel> result =
          await baseFilterRemoteDataSource.filterProducts(
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
              ratingValue: ratingValue);

      return right(result);
    } on NetworkException catch (e) {
      return left(NetworkFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<CategoriesDataModel>>> getCategories() async {
    try {
      List<CategoriesDataModel> res =
          await baseFilterRemoteDataSource.getCategories();
      return right(res);
    } on NetworkException catch (e) {
      return left(NetworkFailure(e.message));
    }
  }
}
