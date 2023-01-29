// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:dio/dio.dart';
import 'package:e_commerce/core/network/dio_helper.dart';
import 'package:e_commerce/core/network/network_exception.dart';
import 'package:e_commerce/features/home/data/model/product_details_model.dart';

import '../../../../core/utilis/constants.dart';
import '../../../categories/data/models/category_details_model.dart';
import '../../../categories/data/models/sub_category_details_model.dart';
import '../../../home/data/model/categories_model.dart';

abstract class BaseFilterRemoteDataSource {
  Future<CategoryDetailsModel> categoryDetails(int id);
  Future<SubCategoryDetailsModel> subCategoryDetails(int id);
  Future<List<CategoriesDataModel>> getCategories();
  Future<List<ProductsDataModel>> filterProducts(
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
      required dynamic ratingValue,
      required int pageNumber});
}

class FilterRemoteDataSource extends BaseFilterRemoteDataSource {
  @override
  Future<SubCategoryDetailsModel> subCategoryDetails(int id) async {
    try {
      Response res = await dio.get('sub-category/$id');
      return SubCategoryDetailsModel.fromJson(res.data['data']);
    } on DioError catch (e) {
      if (e.response?.statusCode == 404) {
        throw NetworkException(message: 'Not Found!');
      } else {
        throw NetworkException(message: 'Network error');
      }
    }
  }

  @override
  Future<CategoryDetailsModel> categoryDetails(int id) async {
    try {
      Response res = await dio.get('category/$id');
      return CategoryDetailsModel.fromJson(res.data['data']);
    } on DioError catch (e) {
      if (e.response?.statusCode == 404) {
        throw NetworkException(message: 'Not Found!');
      } else {
        throw NetworkException(message: 'Network error');
      }
    }
  }

  @override
  Future<List<ProductsDataModel>> filterProducts(
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
      required dynamic ratingValue,
      required int pageNumber}) async {
    List<ProductsDataModel> filteredProducts = [];
    try {
      Response response = await dio.get('filter', queryParameters: {
        'category': categoryId,
        subCategory.toString(): subCategoryId,
        brand.toString(): brandId,
        discount.toString(): discountPercentage,
        priceFrom.toString(): startPrice,
        priceTo.toString(): endPrice,
        orderByPrice.toString(): orderByPriceValue,
        rating.toString(): ratingValue,
        'page': pageNumber
      });
      (response.data['data'] as List).forEach((element) {
        filteredProducts.add(ProductsDataModel.fromJson(element));
      });
      return filteredProducts;
    } on DioError catch (e) {
      if (e.response?.statusCode == 422) {
        throw NetworkException(message: 'Choose Category');
      } else {
        throw NetworkException(message: 'Network error');
      }
    }
  }

  @override
  Future<List<CategoriesDataModel>> getCategories() async {
    try {
      List<CategoriesDataModel> categories = [];
      Response res = await dio.get(
        AppConstants.getCategories,
      );
      (res.data['data'] as List).forEach((element) {
        categories.add(CategoriesDataModel.fromJson(element));
      });
      return categories;
    } on DioError {
      throw NetworkException(message: 'Network Error !!');
    }
  }
}
