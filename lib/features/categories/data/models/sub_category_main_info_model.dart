class SubCategoryMainInfoModel {
  final int? id;
  final String? name;
  final int? categoryId;

  SubCategoryMainInfoModel(this.id, this.name, this.categoryId);

  factory SubCategoryMainInfoModel.fromJson(json) {
    return SubCategoryMainInfoModel(
      json['id'],
      json['name'],
      json['category_id'],
    );
  }
}
