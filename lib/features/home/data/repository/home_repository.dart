import 'package:dartz/dartz.dart';

import 'package:e_commerce/core/network/failure.dart';
import 'package:e_commerce/core/network/network_exception.dart';
import 'package:e_commerce/features/home/data/model/categories_model.dart';
import 'package:e_commerce/features/home/data/remote_data_source/home_remote_data_source.dart';

import '../model/active_user_model.dart';
import '../model/home_products_model.dart';
import '../model/product_details_model.dart';

abstract class HomeBaseRepository {
  Future<Either<Failure, ActiveUserModel>> getActiveUserData(token);
  Future<Either<Failure, HomeProductsModel>> getHomeProducts();
  Future<Either<Failure, List<CategoriesDataModel>>> getCategories();
}

class HomeRepository extends HomeBaseRepository {
  final HomeBaseRemoteDataSource homeBaseRemoteDataSource;

  HomeRepository(this.homeBaseRemoteDataSource);

  @override
  Future<Either<Failure, ActiveUserModel>> getActiveUserData(token) async {
    try {
      ActiveUserModel res =
          await homeBaseRemoteDataSource.getActiveUserData(token);
      return right(res);
    } on NetworkException catch (e) {
      return left(NetworkFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, HomeProductsModel>> getHomeProducts() async {
    try {
      HomeProductsModel res = await homeBaseRemoteDataSource.getHomeProducts();
      return right(res);
    } on NetworkException catch (e) {
      return left(NetworkFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<CategoriesDataModel>>> getCategories() async {
    try {
      List<CategoriesDataModel> res =
          await homeBaseRemoteDataSource.getCategories();
      return right(res);
    } on NetworkException catch (e) {
      return left(NetworkFailure(e.message));
    }
  }
}
