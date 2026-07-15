import 'package:coffee/core/supabase_client.dart';
import 'package:coffee/core/constants/constants.dart';
import 'package:coffee/features/menu/models/base_model.dart';
import 'package:coffee/features/menu/models/product_size_model.dart';

class ProductModel extends BaseModel {
  final String? categoryId;
  final String? productName;
  final String? productSubname;
  final String? description;
  final double? price; // Đây là giá gốc (hoặc giá mặc định)
  final bool? isAvailable;
  final String? productImageUrl;
  final String? categoryName; // Thêm tên category để lọc
  final List<ProductSizeModel>? sizes; 

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
    this.categoryName,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    try {
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
        
        // Cấu trúc trả về từ Supabase khi join bảng categories
        categoryName: _parseCategoryName(json),
        
        sizes: json['products_size'] != null
            ? (json['products_size'] as List)
                .map((s) => ProductSizeModel.fromJson(s))
                .toList()
            : [],
      );
    } catch (e) {
      print("--- FATAL ERROR IN ProductModel.fromJson: $e");
      rethrow;
    }
  }

  // Hàm helper để bóc tách tên category từ JSON lồng nhau
  static String? _parseCategoryName(Map<String, dynamic> json) {
    // 1. Kiểm tra key 'categories' (Theo tên bảng của ông)
    var categoryData = json['categories'] ?? json['category'];
    
    if (categoryData == null) return null;

    // 2. Nếu Supabase trả về dạng List (do quan hệ join)
    if (categoryData is List && categoryData.isNotEmpty) {
      categoryData = categoryData.first;
    }

    // 3. Nếu là Map, lấy giá trị category_name
    if (categoryData is Map) {
      return categoryData['category_name'];
    }

    return null;
  }

  // Tiện ích lấy đường dẫn ảnh từ Supabase Storage hoặc URL có sẵn
  String get fullImageUrl {
    if (productImageUrl == null || productImageUrl!.isEmpty) {
      return ""; // Trả về rỗng để UI xử lý placeholder
    }
    
    // Sử dụng helper từ SupabaseConfig để đồng bộ logic
    return SupabaseConfig.getPublicUrl(
      AppConstants.bucketProducts, 
      productImageUrl!,
    );
  }
}
