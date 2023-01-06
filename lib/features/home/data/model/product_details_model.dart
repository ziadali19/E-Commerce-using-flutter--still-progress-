class ProductsDataModel {
  final dynamic productId;
  final String? productName;
  final String? productImage;
  final String? price;
  final String? discount;
  final String? stock;
  final String? priceAfterDiscount;
  final dynamic rating;
  final bool favorite;

  ProductsDataModel({
    required this.favorite,
    required this.productId,
    required this.productName,
    required this.productImage,
    required this.price,
    required this.discount,
    required this.stock,
    required this.priceAfterDiscount,
    required this.rating,
  });

  factory ProductsDataModel.fromJson(json) {
    return ProductsDataModel(
        productId: json['product_id'],
        productName: json['product_name'],
        productImage: json['product_image'],
        price: json['price'],
        discount: json['discount'],
        stock: json['stock'],
        priceAfterDiscount: json['price_after_discount'],
        rating: json['rating'],
        favorite: json['favorite']);
  }
}
