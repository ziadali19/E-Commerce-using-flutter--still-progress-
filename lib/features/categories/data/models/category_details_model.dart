import 'package:e_commerce/features/home/data/model/product_details_model.dart';

class CategoryDetailsModel {
  final dynamic id;
  final String? name;
  final List<SubCategories> subCategories;
  final List<BrandNameAndIdModel> brands;
  final List<ProductsDataModel> products;

  CategoryDetailsModel(
      {required this.brands,
      required this.id,
      required this.name,
      required this.subCategories,
      required this.products});
  factory CategoryDetailsModel.fromJson(json) {
    return CategoryDetailsModel(
        id: json['category_id'],
        name: json['category_name'],
        subCategories: (json['sub_categories'] as List)
            .map((e) => SubCategories.fromJson(e))
            .toList(),
        brands: (json['brands'] as List)
            .map((e) => BrandNameAndIdModel.fromJson(e))
            .toList(),
        products: (json['products']['data'] as List)
            .map((e) => ProductsDataModel.fromJson(e))
            .toList());
  }
}

class SubCategories {
  final dynamic id;
  final String? name;

  SubCategories({required this.id, required this.name});
  factory SubCategories.fromJson(json) {
    return SubCategories(
      id: json['sub_category_id'],
      name: json['sub_category_name'],
    );
  }
}

class Brands {
  final dynamic id;
  final String? name;
  final List<ProductsDataModel> products;

  Brands({
    required this.id,
    required this.name,
    required this.products,
  });

  factory Brands.fromJson(json) {
    return Brands(
        id: json['brand_id'],
        name: json['brand_name'],
        products: (json['products']['data'] as List)
            .map((e) => ProductsDataModel.fromJson(e))
            .toList());
  }
}

class BrandNameAndIdModel {
  final dynamic id;
  final String? name;

  BrandNameAndIdModel({
    required this.id,
    required this.name,
  });

  factory BrandNameAndIdModel.fromJson(json) {
    return BrandNameAndIdModel(
      id: json['brand_id'],
      name: json['brand_name'],
    );
  }
}
