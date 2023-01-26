import 'package:dio/dio.dart';

import '../../../../core/network/dio_helper.dart';
import '../../../../core/network/network_exception.dart';
import '../model/address_model.dart';

abstract class BaseSettingsRemoteDataSource {
  Future<AddressModel> addAddress(
      String? country, String? state, String? city, String? address);

  Future<AddressModel> getAddress();
}

class SettingsRemoteDataSource extends BaseSettingsRemoteDataSource {
  @override
  Future<AddressModel> addAddress(
      String? country, String? state, String? city, String? address) async {
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
    try {
      Response response = await dio.get('address');
      return AddressModel.fromJson(response.data['data']);
    } on DioError catch (e) {
      throw NetworkException(message: 'Network error');
    }
  }
}
