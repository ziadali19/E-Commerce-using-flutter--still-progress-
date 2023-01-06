import 'package:dartz/dartz.dart';
import 'package:e_commerce/core/network/network_exception.dart';
import 'package:e_commerce/features/register/data/remote_data_source/register_remote_data_source.dart';

import '../../../../core/network/failure.dart';
import '../model/register_model.dart';

abstract class BaseRegisterRepository {
  Future<Either<Failure, RegisterModel>> createUser(String email,
      String password, String confirmPassword, String phone, String name);
}

class RegisterRepository extends BaseRegisterRepository {
  final BaseRegisterRemoteDataSource baseRegisterRemoteDataSource;

  RegisterRepository(this.baseRegisterRemoteDataSource);
  @override
  Future<Either<Failure, RegisterModel>> createUser(
      String email,
      String password,
      String confirmPassword,
      String phone,
      String name) async {
    try {
      RegisterModel result = await baseRegisterRemoteDataSource.createUser(
          email, password, confirmPassword, phone, name);
      return right(result);
    } on ApiException catch (e) {
      return left(ApiFailure(e.errorModel.errorMessage));
    } on NetworkException catch (e) {
      return left(NetworkFailure(e.message));
    }
  }
}
