import 'package:dartz/dartz.dart';
import 'package:e_commerce/core/network/network_exception.dart';
import 'package:e_commerce/features/payments/data/remote_data_source/payments_remote_data_source.dart';

import '../../../../core/network/failure.dart';
import '../model/order_success_model.dart';

abstract class BasePaymentsRepository {
  Future<Either<Failure, OrderSuccessModel>> makeCheckout(
      String? paymentType,
      String? country,
      String? state,
      String? city,
      String? addressDetails,
      String? phone);

  Future<Either<Failure, String>> paymobGetFirstToken();
  Future<Either<Failure, num>> paymobGetOrderId(
      String? price, num? merchantOrderId);
  Future<Either<Failure, String>> paymobGetFinalToken(String? firstName,
      String? lastName, String? email, String? phone, String? price);
}

class PaymentsRepository extends BasePaymentsRepository {
  final BasePaymentsRemoteDataSource basePaymentsRemoteDataSource;

  PaymentsRepository(this.basePaymentsRemoteDataSource);
  @override
  Future<Either<Failure, OrderSuccessModel>> makeCheckout(
      String? paymentType,
      String? country,
      String? state,
      String? city,
      String? addressDetails,
      String? phone) async {
    try {
      OrderSuccessModel result =
          await basePaymentsRemoteDataSource.makeCheckout(
              paymentType, country, state, city, addressDetails, phone);
      return right(result);
    } on NetworkException catch (e) {
      return left(NetworkFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> paymobGetFinalToken(String? firstName,
      String? lastName, String? email, String? phone, String? price) async {
    try {
      String result = await basePaymentsRemoteDataSource.paymobGetFinalToken(
          firstName, lastName, email, phone, price);
      return right(result);
    } on NetworkException catch (e) {
      return left(NetworkFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> paymobGetFirstToken() async {
    try {
      String result = await basePaymentsRemoteDataSource.paymobGetFirstToken();
      return right(result);
    } on NetworkException catch (e) {
      return left(NetworkFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, num>> paymobGetOrderId(
      String? price, num? merchantOrderId) async {
    try {
      num result = await basePaymentsRemoteDataSource.paymobGetOrderId(
          price, merchantOrderId);
      return right(result);
    } on NetworkException catch (e) {
      return left(NetworkFailure(e.message));
    }
  }
}
