import 'package:e_commerce/features/categories/data/models/category_details_model.dart';
import 'package:e_commerce/features/home/data/model/product_details_model.dart';

class SubCategoryDetailsModel {
  final dynamic subCategoryId;
  final dynamic categoryId;
  final String? name;
  final List<BrandNameAndIdModel> brands;
  final List<ProductsDataModel> products;

  SubCategoryDetailsModel(
      {required this.subCategoryId,
      required this.categoryId,
      required this.name,
      required this.brands,
      required this.products});

  factory SubCategoryDetailsModel.fromJson(json) {
    return SubCategoryDetailsModel(
      subCategoryId: json['sub_category_id'],
      categoryId: json['category_id'],
      name: json['sub_category_name'],
      brands: (json['brands'] as List)
          .map((e) => BrandNameAndIdModel.fromJson(e))
          .toList(),
      products: (json['products']['data'] as List)
          .map((e) => ProductsDataModel.fromJson(e))
          .toList(),
    );
  }
}
