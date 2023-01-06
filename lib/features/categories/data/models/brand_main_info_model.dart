class BrandMainInfoModel {
  final int? id;
  final String? name;

  BrandMainInfoModel(this.id, this.name);

  factory BrandMainInfoModel.fromJson(json) {
    return BrandMainInfoModel(
      json['brand_id'],
      json['brand_name'],
    );
  }
}
