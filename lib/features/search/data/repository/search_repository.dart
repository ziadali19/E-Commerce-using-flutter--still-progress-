import 'package:dartz/dartz.dart';
import 'package:e_commerce/core/network/network_exception.dart';
import 'package:e_commerce/features/search/data/remote_data_source.dart/search_remote_data_source.dart';

import '../../../../core/network/failure.dart';
import '../../../home/data/model/product_details_model.dart';

abstract class BaseSearchRepository {
  Future<Either<Failure, List<ProductsDataModel>>> searchProducts(
      String keyWord, int pageNumber);
}

class SearchRepository extends BaseSearchRepository {
  final BaseSearchRemoteDataSource baseSearchRemoteDataSource;

  SearchRepository(this.baseSearchRemoteDataSource);
  @override
  Future<Either<Failure, List<ProductsDataModel>>> searchProducts(
      String keyWord, int pageNumber) async {
    try {
      List<ProductsDataModel> result =
          await baseSearchRemoteDataSource.searchProducts(keyWord, pageNumber);
      return right(result);
    } on NetworkException catch (e) {
      return left(NetworkFailure(e.message));
    }
  }
}
