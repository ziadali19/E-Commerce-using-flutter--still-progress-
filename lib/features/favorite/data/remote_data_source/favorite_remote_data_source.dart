// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:dio/dio.dart';

import 'package:e_commerce/core/network/dio_helper.dart';
import 'package:e_commerce/features/home/data/model/product_details_model.dart';

import '../../../../core/network/network_exception.dart';

abstract class BaseFavoriteRemoteDataSource {
  Future<List<ProductsDataModel>> addOrRemoveFromFavorite(
      int productId, String token);
  Future<List<ProductsDataModel>> getFavorites(String token, int pageNumber);
}

class FavoriteRemoteDataSource extends BaseFavoriteRemoteDataSource {
  @override
  Future<List<ProductsDataModel>> addOrRemoveFromFavorite(
      int productId, String token) async {
    List<ProductsDataModel> favList = [];
    try {
      Response response =
          await dio.post('favorite', data: {'product_id': productId});
      (response.data['data'] as List).forEach((element) {
        favList.add(ProductsDataModel.fromJson(element));
      });
      return favList;
    } on DioError catch (e) {
      if (e.response?.statusCode == 404) {
        throw NetworkException(message: 'Not found');
      } else if (e.response?.statusCode == 401) {
        throw NetworkException(
            message: 'Your login session has expired. please log in again');
      } else if (e.response?.statusCode == 422) {
        throw NetworkException(message: 'The selected product is invalid"');
      } else {
        throw NetworkException(message: 'Network error');
      }
    }
  }

  @override
  Future<List<ProductsDataModel>> getFavorites(
      String token, int pageNumber) async {
    List<ProductsDataModel> favList = [];
    try {
      Response response =
          await dio.get('favorite', queryParameters: {'page': pageNumber});
      (response.data['data'] as List).forEach((element) {
        favList.add(ProductsDataModel.fromJson(element));
      });
      return favList;
    } on DioError catch (e) {
      if (e.response?.statusCode == 401) {
        throw NetworkException(
            message: 'Your login session has expired. please log in again');
      } else {
        throw NetworkException(message: 'Network error');
      }
    }
  }
}
