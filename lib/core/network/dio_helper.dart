import 'package:dio/dio.dart';

import '../utilis/constants.dart';

late Dio dio;
initDio() {
  dio = Dio(BaseOptions(
      baseUrl: AppConstants.baseUrl, receiveDataWhenStatusError: true));
  dio
    ..options.connectTimeout = 20 * 1000
    ..options.receiveTimeout = 20 * 1000;
  dio.interceptors.add(LogInterceptor(
    responseBody: true,
    requestBody: true,
    request: true,
    requestHeader: false,
    responseHeader: false,
  ));
}

late Dio dio1;
initDio1() {
  dio1 = Dio(BaseOptions(
      baseUrl: 'https://accept.paymob.com/api/',
      receiveDataWhenStatusError: true));
  dio1
    ..options.connectTimeout = 20 * 1000
    ..options.receiveTimeout = 20 * 1000;
  dio1.interceptors.add(LogInterceptor(
    responseBody: true,
    requestBody: true,
    request: true,
    requestHeader: false,
    responseHeader: false,
  ));
}
