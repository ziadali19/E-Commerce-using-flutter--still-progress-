class ProductDetailsModel {
  final dynamic productId;
  final String? productName;
  final String? productImage;
  final String? description;
  final String? price;
  final String? discount;
  final String? stock;
  final String? priceAfterDiscount;
  final dynamic rating;
  final List<ProductGallery> gallery;
  final List<ReviewsData> reviews;

  ProductDetailsModel({
    required this.productId,
    required this.productName,
    required this.productImage,
    required this.description,
    required this.price,
    required this.discount,
    required this.stock,
    required this.priceAfterDiscount,
    required this.rating,
    required this.gallery,
    required this.reviews,
  });

  factory ProductDetailsModel.fromJson(json) {
    return ProductDetailsModel(
      productId: json['product_id'],
      productName: json['product_name'],
      productImage: json['product_image'],
      description: json['description'],
      price: json['price'],
      discount: json['discount'],
      stock: json['stock'],
      priceAfterDiscount: json['price_after_discount'],
      rating: json['rating'],
      gallery: (json['gallery'] as List)
          .map((e) => ProductGallery.fromJson(e))
          .toList(),
      reviews: (json['reviews']['data'] as List)
          .map((e) => ReviewsData.fromJson(e))
          .toList(),
    );
  }
}

class ProductGallery {
  final dynamic imageId;
  final String? image;

  ProductGallery({
    required this.imageId,
    required this.image,
  });
  factory ProductGallery.fromJson(json) {
    return ProductGallery(
      imageId: json['image_id'],
      image: json['image'],
    );
  }
}

class ReviewsData {
  final dynamic reviewId;
  final String? comment;
  final String? rating;
  final dynamic productId;
  final Customer customer;

  ReviewsData(
      {required this.reviewId,
      required this.comment,
      required this.rating,
      required this.productId,
      required this.customer});

  factory ReviewsData.fromJson(json) {
    return ReviewsData(
        reviewId: json['review_id'],
        comment: json['comment'],
        rating: json['rating'],
        productId: json['product_id'],
        customer: Customer.fromJson(json['customer']));
  }
}

class Customer {
  final dynamic customerId;
  final String? customerName;
  final String? customerEmail;
  final String? customerPhone;

  Customer({
    required this.customerId,
    required this.customerName,
    required this.customerEmail,
    required this.customerPhone,
  });

  factory Customer.fromJson(json) {
    return Customer(
        customerId: json['customer_id'],
        customerName: json['customer_name'],
        customerEmail: json['customer_email'],
        customerPhone: json['customer_phone']);
  }
}
