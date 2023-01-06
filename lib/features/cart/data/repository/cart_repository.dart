import 'package:dartz/dartz.dart';
import 'package:e_commerce/core/network/failure.dart';
import 'package:e_commerce/core/network/network_exception.dart';
import 'package:e_commerce/features/cart/data/remote_data_source/cart_remote_data_source.dart';

import '../models/cart_model.dart';

abstract class BaseCartRepository {
  Future<Either<Failure, CartModel>> getUserCart(String? token);
  Future<Either<Failure, CartModel>> deleteItemFromCart(
      String? token, int itemId);
  Future<Either<Failure, CartModel>> updateItemAmount(
      String? token, int itemId, int count);
}

class CartRepository extends BaseCartRepository {
  final BaseCartRemoteDataSource baseCartRemoteDataSource;

  CartRepository(this.baseCartRemoteDataSource);
  @override
  Future<Either<Failure, CartModel>> deleteItemFromCart(
      String? token, int itemId) async {
    try {
      CartModel result =
          await baseCartRemoteDataSource.deleteItemFromCart(token, itemId);
      return right(result);
    } on NetworkException catch (e) {
      return left(NetworkFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, CartModel>> getUserCart(String? token) async {
    try {
      CartModel result = await baseCartRemoteDataSource.getUserCart(token);
      return right(result);
    } on NetworkException catch (e) {
      return left(NetworkFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, CartModel>> updateItemAmount(
      String? token, int itemId, int count) async {
    try {
      CartModel result =
          await baseCartRemoteDataSource.updateItemAmount(token, itemId, count);
      return right(result);
    } on NetworkException catch (e) {
      return left(NetworkFailure(e.message));
    }
  }
}
