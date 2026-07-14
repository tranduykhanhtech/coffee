import 'package:coffee/features/menu/models/product_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CoffeeMenuRepository {
  final _supabase = Supabase.instance.client;

  /// Lấy toàn bộ danh sách sản phẩm kèm theo thông tin Size và Giá từ bảng trung gian
  Future<List<ProductModel>> getAllProducts() async {
    try {
      // Thực hiện join 3 bảng: products -> products_size -> size
      // Lấy tất cả thông tin sản phẩm và danh sách size/giá tương ứng trong một lần query
      final response = await _supabase.from('products').select('''
          *,
          products_size (
            id,
            price,
            size:size_id (
              size_type
            )
          )
        ''');

      print("--- DEBUG RAW DATA: $response");

      // Chuyển đổi dữ liệu thô sang danh sách ProductModel
      return (response as List)
          .map((data) => ProductModel.fromJson(data))
          .toList();
    } catch (e) {
      print("--- DEBUG LỖI REPOSITORY: $e");
      rethrow;
    }
  }
}
