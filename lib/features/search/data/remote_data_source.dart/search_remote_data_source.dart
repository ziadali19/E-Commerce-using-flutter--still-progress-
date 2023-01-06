import 'package:dio/dio.dart';
import 'package:dio/src/response.dart';
import 'package:e_commerce/features/home/data/model/product_details_model.dart';

import '../../../../core/network/dio_helper.dart';
import '../../../../core/network/network_exception.dart';

abstract class BaseSearchRemoteDataSource {
  Future<List<ProductsDataModel>> searchProducts(
      String keyWord, int pageNumber);
}

class SearchRemoteDataSource extends BaseSearchRemoteDataSource {
  @override
  Future<List<ProductsDataModel>> searchProducts(
      String keyWord, int pageNumber) async {
    List<ProductsDataModel> searchList = [];
    try {
      Response response = await dio.get('search',
          queryParameters: {'key_word': keyWord, 'page': pageNumber});
      (response.data['data'] as List).forEach((element) {
        searchList.add(ProductsDataModel.fromJson(element));
      });
      return searchList;
    } on DioError catch (e) {
      throw NetworkException(message: 'Network error');
    }
  }
}
