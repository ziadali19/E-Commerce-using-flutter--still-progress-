import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:dio/src/response.dart';
import 'package:e_commerce/core/network/dio_helper.dart';
import 'package:e_commerce/core/network/error_message_model.dart';
import 'package:e_commerce/core/network/failure.dart';
import 'package:e_commerce/core/network/network_exception.dart';
import 'package:e_commerce/core/utilis/constants.dart';
import 'package:e_commerce/features/register/data/model/register_model.dart';

abstract class BaseRegisterRemoteDataSource {
  Future<RegisterModel> createUser(String email, String password,
      String confirmPassword, String phone, String name);
}

class RegisterRemoteDataSource extends BaseRegisterRemoteDataSource {
  @override
  Future<RegisterModel> createUser(String email, String password,
      String confirmPassword, String phone, String name) async {
    RegisterModel userInfo = RegisterModel(
      name: name,
      email: email,
      password: password,
      phone: phone,
      confirmPassword: confirmPassword,
    );

    try {
      Response res = await dio.post(AppConstants.userRegisterEndPoint,
          data: userInfo.toJson());

      return RegisterModel.fromJson(res.data);
    } on DioError catch (e) {
      if (e.response?.statusCode == 422) {
        throw ApiException(errorModel: ErrorModel.fromJson(e.response!.data));
      } else {
        throw NetworkException(message: 'Check your network connection');
      }
    }
  }
}
