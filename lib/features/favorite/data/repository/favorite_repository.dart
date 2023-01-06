import 'package:dartz/dartz.dart';
import 'package:e_commerce/core/network/network_exception.dart';
import 'package:e_commerce/features/favorite/data/remote_data_source/favorite_remote_data_source.dart';

import '../../../../core/network/failure.dart';
import '../../../home/data/model/product_details_model.dart';

abstract class BaseFavoriteRepository {
  Future<Either<Failure, List<ProductsDataModel>>> addOrRemoveFromFavorite(
      int productId, String token);
  Future<Either<Failure, List<ProductsDataModel>>> getFavorites(
      String token, int pageNumber);
}

class FavoriteRepository extends BaseFavoriteRepository {
  final BaseFavoriteRemoteDataSource baseFavoriteRemoteDataSource;

  FavoriteRepository(this.baseFavoriteRemoteDataSource);
  @override
  Future<Either<Failure, List<ProductsDataModel>>> addOrRemoveFromFavorite(
      int productId, String token) async {
    try {
      List<ProductsDataModel> result = await baseFavoriteRemoteDataSource
          .addOrRemoveFromFavorite(productId, token);
      return right(result);
    } on NetworkException catch (e) {
      return left(NetworkFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<ProductsDataModel>>> getFavorites(
      String token, int pageNumber) async {
    try {
      List<ProductsDataModel> result =
          await baseFavoriteRemoteDataSource.getFavorites(token, pageNumber);
      return right(result);
    } on NetworkException catch (e) {
      return left(NetworkFailure(e.message));
    }
  }
}
