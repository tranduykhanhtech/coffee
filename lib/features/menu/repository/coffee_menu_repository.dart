import 'package:coffee/features/menu/models/product_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CoffeeMenuRepository {
  final _supabase = Supabase.instance.client;

  /// Lấy toàn bộ danh sách sản phẩm kèm theo thông tin Size và Giá từ bảng trung gian
  Future<List<ProductModel>> getAllProducts() async {
    try {
      final response = await _supabase.from('products').select('''
          *,
          categories (
            category_name
          ),
          products_size (
            id,
            price,
            size (
              size_type
            )
          )
        ''');

      final List<ProductModel> products = [];
      if (response is List) {
        for (var data in response) {
          try {
            final product = ProductModel.fromJson(data);
            products.add(product);
          } catch (e) {
            print("--- ERROR PARSING PRODUCT ${data['product_name']}: $e");
          }
        }
      }
      return products;
    } catch (e) {
      print("--- DEBUG LỖI REPOSITORY: $e");
      rethrow;
    }
  }
}
