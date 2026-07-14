import 'base_model.dart';

class ProductSizeModel extends BaseModel {
  final String? productId;
  final String? sizeId;
  final double? price;
  final String? sizeType; // Lấy từ bảng size (S, M, L)

  ProductSizeModel(
    super.id,
    super.updatedAt, {
    this.productId,
    this.sizeId,
    this.price,
    this.sizeType,
  });

  factory ProductSizeModel.fromJson(Map<String, dynamic> json) {
    return ProductSizeModel(
      json['id'],
      json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null,
      productId: json['product_id'],
      sizeId: json['size_id'],
      // Lấy size_type từ bảng join 'size'
      sizeType: json['size'] != null ? json['size']['size_type'] : null,
      price: json['price'] != null ? (json['price'] as num).toDouble() : null,
    );
  }
}
