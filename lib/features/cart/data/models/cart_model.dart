import 'package:e_commerce/features/home/data/model/product_details_model.dart';

class CartModel {
  final List<DataModel> data;
  final String? overallPrice;
  final dynamic totalItems;

  CartModel({
    required this.data,
    required this.overallPrice,
    required this.totalItems,
  });

  factory CartModel.fromJson(json) {
    return CartModel(
        overallPrice: json['total_price'],
        totalItems: json['total_items'],
        data: (json['data'] as List).map((element) {
          return DataModel.fromJson(element);
        }).toList());
  }
}

class DataModel {
  final dynamic itemId;
  final String? amount;
  final String? totalPrice;
  final ProductsDataModel product;

  DataModel({
    required this.itemId,
    required this.amount,
    required this.totalPrice,
    required this.product,
  });

  factory DataModel.fromJson(json) {
    return DataModel(
        itemId: json['item_id'],
        amount: json['amount'],
        totalPrice: json['total_price'],
        product: ProductsDataModel.fromJson(json['product']));
  }
}
