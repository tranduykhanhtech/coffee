class OrderModel {
  final String id;
  final String userId;
  final String? orderCode;
  final double totalAmount;
  final double deliveryFee;
  final String orderStatus;
  final String? deliveryAddress;
  final DateTime createdAt;
  final List<OrderDetailModel> details;

  OrderModel({
    required this.id,
    required this.userId,
    this.orderCode,
    required this.totalAmount,
    required this.deliveryFee,
    required this.orderStatus,
    this.deliveryAddress,
    required this.createdAt,
    this.details = const [],
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'],
      userId: json['user_id'],
      orderCode: json['order_code'],
      totalAmount: (json['total_amount'] as num).toDouble(),
      deliveryFee: (json['delivery_fee'] as num).toDouble(),
      orderStatus: json['order_status'],
      deliveryAddress: json['delivery_address'],
      createdAt: DateTime.parse(json['created_at']),
      details: json['order_detail'] != null
          ? (json['order_detail'] as List)
              .map((d) => OrderDetailModel.fromJson(d))
              .toList()
          : [],
    );
  }
}

class OrderDetailModel {
  final String id;
  final String orderId;
  final String productId;
  final int quantity;
  final String? productName;
  final String? productImage;

  OrderDetailModel({
    required this.id,
    required this.orderId,
    required this.productId,
    required this.quantity,
    this.productName,
    this.productImage,
  });

  factory OrderDetailModel.fromJson(Map<String, dynamic> json) {
    // Lấy thông tin product từ join query nếu có
    final product = json['products'];
    return OrderDetailModel(
      id: json['id'],
      orderId: json['order_id'],
      productId: json['product_id'],
      quantity: json['quantity'],
      productName: product != null ? product['product_name'] : null,
      productImage: product != null ? product['product_image_url'] : null,
    );
  }
}
