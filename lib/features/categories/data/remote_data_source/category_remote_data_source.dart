import 'package:dio/dio.dart';

import 'package:e_commerce/core/network/dio_helper.dart';
import 'package:e_commerce/features/categories/data/models/sub_category_details_model.dart';
import 'package:e_commerce/features/categories/data/models/sub_category_main_info_model.dart';

import '../../../../core/network/network_exception.dart';
import '../../../../core/utilis/constants.dart';
import '../../../home/data/model/categories_model.dart';
import '../../../home/data/model/product_details_model.dart';
import '../models/brand_main_info_model.dart';
import '../models/category_details_model.dart';

abstract class BaseCategoryRemoteDataSource {
  Future<CategoryDetailsModel> categoryDetails(int id, int pageNumber);
  Future<List<CategoriesDataModel>> getCategories();
  Future<List<SubCategoryMainInfoModel>> getSubCategories();
  Future<List<BrandMainInfoModel>> getBrands();
  Future<SubCategoryDetailsModel> subCategoryDetails(int id, int pageNumber);
  Future<Brands> brandDetails(int id, int pageNumber);
  Future<List<ProductsDataModel>> filterProducts(
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

class CategoryRemoteDataSource extends BaseCategoryRemoteDataSource {
  @override
  Future<CategoryDetailsModel> categoryDetails(int id, int pageNumber) async {
    try {
      Response res =
          await dio.get('category/$id', queryParameters: {'page': pageNumber});
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
  Future<SubCategoryDetailsModel> subCategoryDetails(
      int id, int pageNumber) async {
    try {
      Response res = await dio
          .get('sub-category/$id', queryParameters: {'page': pageNumber});
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

  @override
  Future<Brands> brandDetails(int id, int pageNumber) async {
    try {
      Response res =
          await dio.get('brand/$id', queryParameters: {'page': pageNumber});
      return Brands.fromJson(res.data['data']);
    } on DioError catch (e) {
      if (e.response?.statusCode == 404) {
        throw NetworkException(message: 'Not Found!');
      } else {
        throw NetworkException(message: 'Network error');
      }
    }
  }

  ///////////filter
  @override
  Future<List<ProductsDataModel>> filterProducts(
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
    List<ProductsDataModel> filteredProducts = [];
    try {
      Response response = await dio.get('filter', queryParameters: {
        'category': categoryId,
        subCategory.toString(): subCategoryId,
        brand.toString(): brandId,
        discount.toString(): discountPercentage,
        price.toString(): priceRange,
        orderByPrice.toString(): orderByPriceValue,
        rating.toString(): ratingValue
      });
      (response.data['data'] as List).forEach((element) {
        filteredProducts.add(element);
      });
      return filteredProducts;
    } on DioError catch (e) {
      if (e.response?.statusCode == 404) {
        throw NetworkException(message: 'Not Found!');
      } else {
        throw NetworkException(message: 'Network error');
      }
    }
  }

  @override
  Future<List<SubCategoryMainInfoModel>> getSubCategories() async {
    try {
      List<SubCategoryMainInfoModel> subCategories = [];
      Response res = await dio.get(
        'sub-category',
      );
      (res.data['data'] as List).forEach((element) {
        subCategories.add(SubCategoryMainInfoModel.fromJson(element));
      });
      return subCategories;
    } on DioError {
      throw NetworkException(message: 'Network Error !!');
    }
  }

  @override
  Future<List<BrandMainInfoModel>> getBrands() async {
    try {
      List<BrandMainInfoModel> brands = [];
      Response res = await dio.get('brand');
      (res.data['data'] as List).forEach((element) {
        brands.add(BrandMainInfoModel.fromJson(element));
      });
      return brands;
    } on DioError {
      throw NetworkException(message: 'Network Error !!');
    }
  }
}
