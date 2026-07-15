import 'package:supabase_flutter/supabase_flutter.dart';

class OrderRepository {
  final _supabase = Supabase.instance.client;

  User? get currentUser => _supabase.auth.currentUser;

  /// Lấy lịch sử đơn hàng kèm chi tiết sản phẩm
  Future<List<dynamic>> getOrderHistory(String userId) async {
    try {
      final response = await _supabase
          .from('orders')
          .select('''
            *,
            order_detail (
              *,
              products (
                product_name,
                product_image_url
              )
            )
          ''')
          .eq('user_id', userId)
          .order('created_at', ascending: false);
      return response as List<dynamic>;
    } catch (e) {
      print("--- ERROR getOrderHistory: $e");
      rethrow;
    }
  }

  /// Tạo đơn hàng mới sau khi thanh toán thành công
  Future<void> placeOrder({
    required String userId,
    required double totalAmount,
    required double deliveryFee,
    required String address,
    required List<Map<String, dynamic>> items,
    String? paymentId, // Bổ sung paymentId
  }) async {
    try {
      // 1. Tạo đơn hàng chính
      final orderResponse = await _supabase.from('orders').insert({
        'user_id': userId,
        'total_amount': totalAmount,
        'delivery_fee': deliveryFee,
        'delivery_address': address,
        'discount_amount': 0, // Theo schema là NOT NULL
        'order_status': 'PENDING',
        'order_code': 'ORD-${DateTime.now().millisecondsSinceEpoch}',
        'payment_id': paymentId, // Lưu tham chiếu tới bảng payments
      }).select().single();

      final String orderId = orderResponse['id'];

      // 2. Tạo chi tiết đơn hàng cho từng món
      final List<Map<String, dynamic>> orderDetails = items.map((item) {
        return {
          'order_id': orderId,
          'product_id': item['product_id'],
          'quantity': item['quantity'],
        };
      }).toList();

      await _supabase.from('order_detail').insert(orderDetails);
      
    } catch (e) {
      print("--- ERROR placeOrder: $e");
      rethrow;
    }
  }
}
