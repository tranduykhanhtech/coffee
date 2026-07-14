import 'package:supabase_flutter/supabase_flutter.dart';

class CartRepository {
  final _supabase = Supabase.instance.client;

  User? get currentUser => _supabase.auth.currentUser;

  Future<List<dynamic>> fetchCartItems() async {
    return await _supabase
        .from('cart_items')
        .select('*, product_size:product_size_id(*, product:product_id(*))');
  }

  Future<void> upsertCartItem(String userId, String productSizeId, int quantity) async {
    await _supabase.from('cart_items').upsert({
      'user_id': userId,
      'product_size_id': productSizeId,
      'quantity': quantity,
    }, onConflict: 'user_id, product_size_id');
  }

  Future<void> removeCartItem(String userId, String productSizeId) async {
    await _supabase.from('cart_items').delete().match({
      'user_id': userId,
      'product_size_id': productSizeId,
    });
  }

  Future<void> clearCart(String userId) async {
    await _supabase.from('cart_items').delete().eq('user_id', userId);
  }
}
