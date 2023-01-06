import 'package:dio/dio.dart';
import 'package:e_commerce/core/network/dio_helper.dart';
import 'package:e_commerce/features/product/data/models/product_details_model.dart';

import '../../../../core/network/network_exception.dart';

abstract class BaseProductRemoteDataSource {
  Future<ProductDetailsModel> getProductDetails(int id, int pageNumber);
  Future<String> addToCart(int productId, String token);
}

class ProductRemoteDataSource extends BaseProductRemoteDataSource {
  @override
  Future<ProductDetailsModel> getProductDetails(int id, int pageNumber) async {
    try {
      Response res =
          await dio.get('product/$id', queryParameters: {'page': pageNumber});
      return ProductDetailsModel.fromJson(res.data['data']);
    } on DioError catch (e) {
      if (e.response?.statusCode == 404) {
        throw NetworkException(message: 'Not Found!');
      } else {
        throw NetworkException(message: 'Network error');
      }
    }
  }

  @override
  Future<String> addToCart(int productId, String token) async {
    try {
      dio.options.headers = {'Authorization': 'Bearer $token'};
      Response response =
          await dio.post('cart', data: {'product_id': productId});
      return (response.data['message'] as String);
    } on DioError catch (e) {
      if (e.response?.statusCode == 422) {
        throw NetworkException(message: 'Something went wrong');
      } else {
        throw NetworkException(message: 'Network error');
      }
    }
  }
}
