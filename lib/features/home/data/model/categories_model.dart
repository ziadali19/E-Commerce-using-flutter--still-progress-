class CategoriesDataModel {
  final dynamic id;
  final String? name;

  CategoriesDataModel({required this.id, required this.name});
  factory CategoriesDataModel.fromJson(json) {
    return CategoriesDataModel(id: json['id'], name: json['name']);
  }
}
