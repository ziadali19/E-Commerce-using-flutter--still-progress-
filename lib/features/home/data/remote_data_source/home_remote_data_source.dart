import 'package:dio/dio.dart';
import 'package:e_commerce/core/utilis/constants.dart';
import 'package:e_commerce/features/home/data/model/active_user_model.dart';
import 'package:e_commerce/features/home/data/model/categories_model.dart';
import 'package:e_commerce/features/home/data/model/home_products_model.dart';
import 'package:e_commerce/features/home/data/model/product_details_model.dart';

import '../../../../core/network/dio_helper.dart';
import '../../../../core/network/network_exception.dart';

abstract class HomeBaseRemoteDataSource {
  Future<ActiveUserModel> getActiveUserData(token);
  Future<HomeProductsModel> getHomeProducts();
  Future<List<CategoriesDataModel>> getCategories();
}

class HomeRemoteDataSource extends HomeBaseRemoteDataSource {
  @override
  Future<ActiveUserModel> getActiveUserData(token) async {
    try {
      dio.options.headers = {'Authorization': 'Bearer $token'};
      Response res = await dio.get(AppConstants.getActiveUserData);
      return ActiveUserModel.fromJson(res.data);
    } on DioError catch (e) {
      if (e.response?.statusCode == 401) {
        throw NetworkException(
            message: 'Your login session has expired. please log in again');
      } else {
        throw NetworkException(message: 'Check your network connection');
      }
    }
  }

  @override
  Future<HomeProductsModel> getHomeProducts() async {
    try {
      Response res = await dio.get('products/home-page');

      return HomeProductsModel.fromJson(res.data);
    } on DioError {
      throw NetworkException(message: 'Network Error !!');
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
