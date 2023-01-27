import 'package:dio/dio.dart';
import 'package:e_commerce/features/settings/data/model/orders_details_model.dart';

import '../../../../core/network/dio_helper.dart';
import '../../../../core/network/network_exception.dart';
import '../../../../core/utilis/constants.dart';
import '../../../../main.dart';
import '../model/address_model.dart';

abstract class BaseSettingsRemoteDataSource {
  Future<AddressModel> addAddress(
      String? country, String? state, String? city, String? address);

  Future<AddressModel> getAddress();

  Future<List<OrderDetailsModel>> getUserOrders();

  Future<String> userLogOut();
}

class SettingsRemoteDataSource extends BaseSettingsRemoteDataSource {
  @override
  Future<AddressModel> addAddress(
      String? country, String? state, String? city, String? address) async {
    dio.options.headers = {'Authorization': 'Bearer $token'};
    AddressModel addressModel = AddressModel(
        country: country, state: state, city: city, addressDetails: address);
    try {
      Response response =
          await dio.post('address', data: addressModel.toJson());
      return AddressModel.fromJson(response.data['data']);
    } on DioError catch (e) {
      throw NetworkException(message: 'Network error');
    }
  }

  @override
  Future<AddressModel> getAddress() async {
    dio.options.headers = {'Authorization': 'Bearer $token'};
    try {
      Response response = await dio.get('address');
      return AddressModel.fromJson(response.data['data']);
    } on DioError catch (e) {
      throw NetworkException(message: 'Network error');
    }
  }

  @override
  Future<List<OrderDetailsModel>> getUserOrders() async {
    dio.options.headers = {'Authorization': 'Bearer $token'};
    List<OrderDetailsModel> ordersList = [];
    try {
      Response response = await dio.get('order');
      (response.data['data'] as List).forEach((element) {
        ordersList.add(OrderDetailsModel.fromJson(element));
      });
      return ordersList;
    } on DioError catch (e) {
      throw NetworkException(message: 'Network error');
    }
  }

  @override
  Future<String> userLogOut() async {
    dio.options.headers = {'Authorization': 'Bearer $token'};
    try {
      Response response = await dio.get('customer/logout');
      return response.data['message'];
    } on DioError catch (e) {
      if (e.response!.statusCode == 404) {
        throw NetworkException(message: 'Not found');
      } else {
        throw NetworkException(message: 'Network error');
      }
    }
  }
}
