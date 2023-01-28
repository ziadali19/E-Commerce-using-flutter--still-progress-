import 'package:e_commerce/features/home/data/model/product_details_model.dart';

class HomeProductsModel {
  final List<ProductsDataModel> bestOffers;
  final List<ProductsDataModel> trending;
  final List<ProductsDataModel> newArrival;
  final List<ProductsDataModel> bestSeller;
  final List<ProductsDataModel> topRated;

  HomeProductsModel(
      {required this.bestOffers,
      required this.trending,
      required this.newArrival,
      required this.bestSeller,
      required this.topRated});

  factory HomeProductsModel.fromJson(json) {
    return HomeProductsModel(
        bestOffers: (json['best_offers'] as List).map((e) {
          return ProductsDataModel.fromJson(e);
        }).toList(),
        trending: (json['trending'] as List).map((e) {
          return ProductsDataModel.fromJson(e);
        }).toList(),
        newArrival: (json['new_arrival'] as List).map((e) {
          return ProductsDataModel.fromJson(e);
        }).toList(),
        bestSeller: (json['best_seller'] as List).map((e) {
          return ProductsDataModel.fromJson(e);
        }).toList(),
        topRated: (json['top_rated'] as List).map((e) {
          return ProductsDataModel.fromJson(e);
        }).toList());
  }
}
