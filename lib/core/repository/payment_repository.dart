import 'package:supabase_flutter/supabase_flutter.dart';

class PaymentRepository {
  final _supabase = Supabase.instance.client;

  User? get currentUser => _supabase.auth.currentUser;

  /// Lấy danh sách các phương thức thanh toán của người dùng (nếu có lưu thẻ)
  Future<List<Map<String, dynamic>>> getUserPaymentMethods(String userId) async {
    return await _supabase
        .from('payments')
        .select('*')
        .eq('user_id', userId);
  }

  /// Tạo bản ghi thanh toán mới
  Future<String> createPaymentRecord({
    required String userId,
    required String method, // 'CASH', 'BANK_TRANSFER' (Stripe), v.v.
    required String status, // 'PENDING', 'SUCCESS', 'FAILED'
  }) async {
    final response = await _supabase.from('payments').insert({
      'user_id': userId,
      'payment_method': method,
      'payment_status': status,
    }).select().single();
    
    return response['id'];
  }
}
