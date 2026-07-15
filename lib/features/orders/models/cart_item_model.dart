import '../../../core/constants/constants.dart';
import '../../../core/supabase_client.dart';

class CartItemModel {
  final String? productId; // Thêm productId để tạo order detail
  final String productSizeId;
  final int quantity;
  final String? productName;
  final String? productSubname;
  final String? imageUrl;
  final double? price;

  CartItemModel({
    this.productId,
    required this.productSizeId,
    required this.quantity,
    this.productName,
    this.productSubname,
    this.imageUrl,
    this.price,
  });

  Map<String, dynamic> toJson() {
    return {
      'product_id': productId,
      'product_size_id': productSizeId,
      'quantity': quantity,
      'product_name': productName,
      'product_subname': productSubname,
      'image_url': imageUrl,
      'price': price,
    };
  }

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      productId: json['product_id'],
      productSizeId: json['product_size_id'],
      quantity: json['quantity'],
      productName: json['product_name'],
      productSubname: json['product_subname'],
      imageUrl: json['image_url'],
      price: json['price'] != null ? (json['price'] as num).toDouble() : null,
    );
  }

  CartItemModel copyWith({
    String? productId,
    String? productSizeId,
    int? quantity,
    String? productName,
    String? productSubname,
    String? imageUrl,
    double? price,
  }) {
    return CartItemModel(
      productId: productId ?? this.productId,
      productSizeId: productSizeId ?? this.productSizeId,
      quantity: quantity ?? this.quantity,
      productName: productName ?? this.productName,
      productSubname: productSubname ?? this.productSubname,
      imageUrl: imageUrl ?? this.imageUrl,
      price: price ?? this.price,
    );
  }

  // Getter lấy URL đầy đủ từ Supabase
  String get fullImageUrl {
    if (imageUrl == null || imageUrl!.isEmpty) return "";
    return SupabaseConfig.getPublicUrl(AppConstants.bucketProducts, imageUrl!);
  }
}
