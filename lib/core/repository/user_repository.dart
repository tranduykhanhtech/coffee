import 'package:supabase_flutter/supabase_flutter.dart';

class UserRepository {
  final _supabase = Supabase.instance.client;

  User? get currentUser => _supabase.auth.currentUser;

  /// Lấy thông tin user từ bảng public.users
  Future<Map<String, dynamic>?> getUserProfile(String userId) async {
    return await _supabase
        .from('users')
        .select('*')
        .eq('id', userId)
        .maybeSingle();
  }

  /// Cập nhật thông tin profile (bao gồm địa chỉ text)
  Future<void> updateProfile(String userId, Map<String, dynamic> data) async {
    await _supabase
        .from('users')
        .update(data)
        .eq('id', userId);
  }
}
