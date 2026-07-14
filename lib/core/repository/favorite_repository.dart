import 'package:supabase_flutter/supabase_flutter.dart';

class FavoriteRepository {
  final _supabase = Supabase.instance.client;

  // Thêm getter để Service lấy user hiện tại
  User? get currentUser => _supabase.auth.currentUser;

  Future<List<Map<String, dynamic>>> fetchFavorites(String userId) async {
    return await _supabase
        .from('favorites')
        .select('product_id')
        .eq('user_id', userId);
  }

  Future<void> addFavorite(String userId, String productId) async {
    await _supabase.from('favorites').insert({
      'user_id': userId,
      'product_id': productId,
    });
  }

  Future<void> removeFavorite(String userId, String productId) async {
    await _supabase.from('favorites').delete().match({
      'user_id': userId,
      'product_id': productId,
    });
  }

  Future<void> upsertFavorite(String userId, String productId) async {
    await _supabase.from('favorites').upsert({
      'user_id': userId,
      'product_id': productId,
    }, onConflict: 'user_id, product_id');
  }
}
