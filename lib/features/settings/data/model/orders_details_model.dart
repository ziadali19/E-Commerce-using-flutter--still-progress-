class OrderDetailsModel {
  final int? id;
  final String? totalPrice;
  final String? paymentType;
  final String? paymentStatus;
  final num? transactionId;
  final String? delivery;
  final int? customerId;
  final String? createdAt;
  final String? updatedAt;

  OrderDetailsModel(
      {required this.id,
      required this.totalPrice,
      required this.paymentType,
      required this.paymentStatus,
      required this.transactionId,
      required this.delivery,
      required this.customerId,
      required this.createdAt,
      required this.updatedAt});

  factory OrderDetailsModel.fromJson(json) {
    return OrderDetailsModel(
        id: json['id'],
        totalPrice: json['total_price'],
        paymentType: json['payment_type'],
        paymentStatus: json['payment_status'],
        transactionId: json['transaction_id'],
        delivery: json['delivery'],
        customerId: json['customer_id'],
        createdAt: json['created_at'],
        updatedAt: json['updated_at']);
  }
}
