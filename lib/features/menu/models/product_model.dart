import 'package:coffee/features/menu/models/base_model.dart';
import 'package:coffee/features/menu/models/product_size_model.dart'; // Thêm import

class ProductModel extends BaseModel {
  final String? categoryId;
  final String? productName;
  final String? productSubname;
  final String? description;
  final double? price; // Đây là giá gốc (hoặc giá mặc định)
  final bool? isAvailable;
  final String? productImageUrl;
  final List<ProductSizeModel>? sizes; // Danh sách các size và giá tương ứng

  ProductModel(
    super.id,
    super.updatedAt, {
    this.categoryId,
    this.productName,
    this.description,
    this.isAvailable,
    this.productImageUrl,
    this.productSubname,
    this.price,
    this.sizes,
  });

  // Hàm chuyển đổi dữ liệu từ Supabase (Map/JSON) sang Model
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      json['id'],
      json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null,
      categoryId: json['category_id'],
      productName: json['product_name'],
      productSubname: json['product_subname'],
      description: json['description'],
      productImageUrl: json['product_image_url'],
      isAvailable: json['is_available'] ?? true,
      price: json['price'] != null ? (json['price'] as num).toDouble() : null,
      
      // Khởi tạo danh sách size từ dữ liệu join 'products_size'
      sizes: json['products_size'] != null
          ? (json['products_size'] as List)
              .map((s) => ProductSizeModel.fromJson(s))
              .toList()
          : [],
    );
  }
}

