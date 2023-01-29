import 'package:dio/dio.dart';
import 'package:e_commerce/core/network/dio_helper.dart';
import 'package:e_commerce/core/network/network_exception.dart';
import 'package:e_commerce/core/utilis/constants.dart';
import 'package:e_commerce/features/payments/data/model/order_success_model.dart';

abstract class BasePaymentsRemoteDataSource {
  Future<OrderSuccessModel> makeCheckout(String? paymentType, String? country,
      String? state, String? city, String? addressDetails, String? phone);
  Future<String> paymobGetFirstToken();
  Future<num> paymobGetOrderId(String? price, num? merchantOrderId);
  Future<String> paymobGetFinalToken(String? firstName, String? lastName,
      String? email, String? phone, String? price);
}

class PaymentsRemoteDataSource extends BasePaymentsRemoteDataSource {
  @override
  Future<OrderSuccessModel> makeCheckout(
      String? paymentType,
      String? country,
      String? state,
      String? city,
      String? addressDetails,
      String? phone) async {
    dio.options.headers = {'Authorization': 'Bearer $token'};
    try {
      Response response = await dio.post('checkout', data: {
        "payment_type": paymentType,
        "country": country,
        "state": state,
        "city": city,
        "address": addressDetails,
        "phone": phone
      });
      return OrderSuccessModel.fromJson(response.data['data']);
    } on DioError catch (e) {
      if (e.response!.statusCode == 422) {
        throw NetworkException(message: e.response!.data['message']);
      } else {
        throw NetworkException(message: 'Network error');
      }
    }
  }

  @override
  Future<String> paymobGetFirstToken() async {
    try {
      Response response = await dio1
          .post('auth/tokens', data: {'api_key': AppConstants.paymobApiKey});
      return response.data['token'];
    } on DioError catch (e) {
      throw NetworkException(message: e.message);
    }
  }

  @override
  Future<num> paymobGetOrderId(String? price, num? merchantOrderId) async {
    try {
      Response response = await dio1.post('ecommerce/orders', data: {
        "auth_token": AppConstants.paymobFirstToken,
        "delivery_needed": "true",
        "amount_cents": price,
        "currency": "EGP",
        "merchant_order_id": merchantOrderId,
        "items": [],
      });
      return response.data['id'];
    } on DioError catch (e) {
      throw NetworkException(message: e.message);
    }
  }

  @override
  Future<String> paymobGetFinalToken(String? firstName, String? lastName,
      String? email, String? phone, String? price) async {
    try {
      Response response = await dio1.post('acceptance/payment_keys', data: {
        "auth_token": AppConstants.paymobFirstToken,
        "amount_cents": price,
        "expiration": 3600,
        "order_id": AppConstants.paymobOrderId,
        "billing_data": {
          "apartment": "NA",
          "email": email,
          "floor": "NA",
          "first_name": firstName,
          "street": "NA",
          "building": "NA",
          "phone_number": phone,
          "shipping_method": "NA",
          "postal_code": "NA",
          "city": "NA",
          "country": "NA",
          "last_name": lastName,
          "state": "NA"
        },
        "currency": "EGP",
        "integration_id": AppConstants.paymobIntegratioIdCard,
        "lock_order_when_paid": "false"
      });
      return response.data['token'];
    } on DioError catch (e) {
      throw NetworkException(message: e.message);
    }
  }
}
