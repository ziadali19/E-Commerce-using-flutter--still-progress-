import 'package:dio/dio.dart';
import 'package:e_commerce/features/cart/data/models/cart_model.dart';

import '../../../../core/network/dio_helper.dart';
import '../../../../core/network/network_exception.dart';

abstract class BaseCartRemoteDataSource {
  Future<CartModel> getUserCart(String? token);
  Future<CartModel> deleteItemFromCart(String? token, int itemId);
  Future<CartModel> updateItemAmount(String? token, int itemId, int count);
}

class CartRemoteDataSource extends BaseCartRemoteDataSource {
  @override
  Future<CartModel> getUserCart(String? token) async {
    try {
      Response response = await dio.get('cart');
      dio.options.headers = {'Authorization': 'Bearer $token'};
      return CartModel.fromJson(response.data);
    } on DioError catch (e) {
      if (e.response?.statusCode == 401) {
        throw NetworkException(
            message: 'Your login session has expired. please log in again');
      } else {
        throw NetworkException(message: 'Network error');
      }
    }
  }

  @override
  Future<CartModel> deleteItemFromCart(String? token, int itemId) async {
    try {
      Response response = await dio.delete('cart/$itemId');
      dio.options.headers = {'Authorization': 'Bearer $token'};
      return CartModel.fromJson(response.data);
    } on DioError catch (e) {
      if (e.response?.statusCode == 404) {
        throw NetworkException(message: 'Not found');
      } else if (e.response?.statusCode == 401) {
        throw NetworkException(
            message: 'Your login session has expired. please log in again');
      } else {
        throw NetworkException(message: 'Network error');
      }
    }
  }

  @override
  Future<CartModel> updateItemAmount(
      String? token, int itemId, int count) async {
    try {
      Response response =
          await dio.put('cart/$itemId', data: {'amount': count});
      dio.options.headers = {'Authorization': 'Bearer $token'};
      return CartModel.fromJson(response.data);
    } on DioError catch (e) {
      if (e.response?.statusCode == 404) {
        throw NetworkException(message: 'Not found');
      } else if (e.response?.statusCode == 401) {
        throw NetworkException(
            message: 'Your login session has expired. please log in again');
      } else if (e.response?.statusCode == 422) {
        throw NetworkException(message: 'The amount field is required');
      } else {
        throw NetworkException(message: 'Network error');
      }
    }
  }
}
