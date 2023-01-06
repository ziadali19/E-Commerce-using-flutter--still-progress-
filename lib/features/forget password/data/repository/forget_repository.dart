import 'package:dartz/dartz.dart';
import 'package:e_commerce/core/network/network_exception.dart';
import 'package:e_commerce/features/forget%20password/data/remote_data_source/forget_remote_data_source.dart';

import '../../../../core/network/failure.dart';

abstract class BaseForgetRepository {
  Future<Either<Failure, String>> forgetPassword(String email);
}

class ForgetRepository extends BaseForgetRepository {
  final BaseForgetRemoteDataSource baseForgetRemoteDataSource;

  ForgetRepository(this.baseForgetRemoteDataSource);
  @override
  Future<Either<Failure, String>> forgetPassword(String email) async {
    try {
      String result = await baseForgetRemoteDataSource.forgetPassword(email);
      return right(result);
    } on NetworkException catch (e) {
      return left(NetworkFailure(e.message));
    }
  }
}
