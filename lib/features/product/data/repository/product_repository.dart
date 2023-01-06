import 'package:dartz/dartz.dart';
import 'package:e_commerce/core/network/network_exception.dart';
import 'package:e_commerce/features/product/data/remote_data_source/product_remote_data_source.dart';

import '../../../../core/network/failure.dart';
import '../models/product_details_model.dart';

abstract class BaseProductRepository {
  Future<Either<Failure, ProductDetailsModel>> getProductDetails(
      int id, int pageNumber);
  Future<Either<Failure, String>> addToCart(int productId, String token);
}

class ProductRepository extends BaseProductRepository {
  final BaseProductRemoteDataSource baseProductRemoteDataSource;

  ProductRepository(this.baseProductRemoteDataSource);
  @override
  Future<Either<Failure, ProductDetailsModel>> getProductDetails(
      int id, int pageNumber) async {
    try {
      ProductDetailsModel result =
          await baseProductRemoteDataSource.getProductDetails(id, pageNumber);
      return right(result);
    } on NetworkException catch (e) {
      return left(NetworkFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> addToCart(int productId, String token) async {
    try {
      String result =
          await baseProductRemoteDataSource.addToCart(productId, token);
      return right(result);
    } on NetworkException catch (e) {
      return left(NetworkFailure(e.message));
    }
  }
}
