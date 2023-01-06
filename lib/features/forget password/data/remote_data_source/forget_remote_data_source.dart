import 'package:dio/dio.dart';
import 'package:e_commerce/core/utilis/constants.dart';

import '../../../../core/network/dio_helper.dart';
import '../../../../core/network/network_exception.dart';

abstract class BaseForgetRemoteDataSource {
  Future<String> forgetPassword(String email);
}

class ForgetRemoteDataSource extends BaseForgetRemoteDataSource {
  @override
  Future<String> forgetPassword(String email) async {
    try {
      Response res =
          await dio.post(AppConstants.forgetPassword, data: {'email:$email'});
      return res.data['message'];
    } on DioError catch (e) {
      if (e.response?.statusCode == 422) {
        throw NetworkException(message: 'The selected email is invalid.');
      } else {
        throw NetworkException(message: 'Network error');
      }
    }
  }
}
