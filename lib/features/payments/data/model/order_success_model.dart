class OrderSuccessModel {
  final String? curruencyType;
  final num? orderId;
  final num? totalPrice;

  OrderSuccessModel(
      {required this.curruencyType,
      required this.orderId,
      required this.totalPrice});
  factory OrderSuccessModel.fromJson(json) {
    return OrderSuccessModel(
        curruencyType: json['currency_type'],
        orderId: json['order_id'],
        totalPrice: json['total_price']);
  }
}
