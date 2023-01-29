import 'package:dio/dio.dart';

import '../../../../core/network/dio_helper.dart';

import '../../../../core/network/network_exception.dart';
import '../../../../core/utilis/constants.dart';
import '../model/login_model.dart';

abstract class BaseLoginRemoteDataSource {
  Future<LoginModel> userLogin(
    String email,
    String password,
  );
}

class LoginRemoteDataSource extends BaseLoginRemoteDataSource {
  @override
  Future<LoginModel> userLogin(
    String email,
    String password,
  ) async {
    try {
      Response res = await dio.post(AppConstants.userLoginEndPoint,
          data: {'email': email, 'password': password});

      return LoginModel.fromJson(res.data);
    } on DioError catch (e) {
      if (e.response?.statusCode == 401) {
        throw NetworkException(message: 'The email or password is incorrect');
      } else {
        throw NetworkException(message: 'Check your network connection');
      }
    }
  }
}
