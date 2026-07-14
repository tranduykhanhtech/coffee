import 'package:supabase_flutter/supabase_flutter.dart';

class OrderRepository {
  final _supabase = Supabase.instance.client;

  /// Chốt đơn hàng: Đẩy data lên bảng orders và order_detail
  /// Theo README: Logic này thuộc Nhóm RIÊNG BIỆT (Feature: Orders)
  Future<void> placeOrder({
    required String userId,
    required double totalAmount,
    required String address,
    required List<Map<String, dynamic>> items,
  }) async {
    // Logic chốt đơn sẽ được thực hiện tại đây (Giai đoạn 2 của ô)
  }

  Future<List<dynamic>> getOrderHistory(String userId) async {
    return await _supabase
        .from('orders')
        .select('*, order_detail(*)')
        .eq('user_id', userId);
  }
}
