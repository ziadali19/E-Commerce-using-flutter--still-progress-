import 'package:dartz/dartz.dart';
import 'package:e_commerce/features/settings/data/remote_data_source/settings_remote_data_source.dart';

import '../../../../core/network/failure.dart';
import '../../../../core/network/network_exception.dart';
import '../model/address_model.dart';
import '../model/orders_details_model.dart';

abstract class BaseSettingsRepository {
  Future<Either<Failure, AddressModel>> addAddress(
      String? country, String? state, String? city, String? address);

  Future<Either<Failure, AddressModel>> getAddress();
  Future<Either<Failure, List<OrderDetailsModel>>> getUserOrders();
  Future<Either<Failure, String>> userLogOut();
}

class SettingsRepository extends BaseSettingsRepository {
  final BaseSettingsRemoteDataSource baseSettingsRemoteDataSource;

  SettingsRepository(this.baseSettingsRemoteDataSource);
  @override
  Future<Either<Failure, AddressModel>> addAddress(
      String? country, String? state, String? city, String? address) async {
    try {
      AddressModel result = await baseSettingsRemoteDataSource.addAddress(
          country, state, city, address);
      return right(result);
    } on NetworkException catch (e) {
      return left(NetworkFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, AddressModel>> getAddress() async {
    try {
      AddressModel result = await baseSettingsRemoteDataSource.getAddress();
      return right(result);
    } on NetworkException catch (e) {
      return left(NetworkFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<OrderDetailsModel>>> getUserOrders() async {
    try {
      List<OrderDetailsModel> result =
          await baseSettingsRemoteDataSource.getUserOrders();
      return right(result);
    } on NetworkException catch (e) {
      return left(NetworkFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> userLogOut() async {
    try {
      String result = await baseSettingsRemoteDataSource.userLogOut();
      return right(result);
    } on NetworkException catch (e) {
      return left(NetworkFailure(e.message));
    }
  }
}
