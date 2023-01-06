import 'package:dartz/dartz.dart';

import '../../../../core/network/failure.dart';
import '../../../../core/network/network_exception.dart';

import '../model/login_model.dart';
import '../remote_data_source.dart/login_remote_data_source.dart';

abstract class BaseLoginRepository {
  Future<Either<Failure, LoginModel>> userLogin(String email, String password);
}

class LoginRepository extends BaseLoginRepository {
  final BaseLoginRemoteDataSource baseLoginRemoteDataSource;

  LoginRepository(this.baseLoginRemoteDataSource);

  @override
  Future<Either<Failure, LoginModel>> userLogin(
    String email,
    String password,
  ) async {
    try {
      LoginModel result =
          await baseLoginRemoteDataSource.userLogin(email, password);
      return right(result);
    } on NetworkException catch (e) {
      return left(NetworkFailure(e.message));
    }
  }
}
