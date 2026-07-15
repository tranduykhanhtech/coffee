import 'package:supabase_flutter/supabase_flutter.dart';
import 'constants/api_keys.dart';

/// Nơi duy nhất khởi tạo và quản lý Supabase Client theo README.md
class SupabaseConfig {
  SupabaseConfig._();

  static SupabaseClient get client => Supabase.instance.client;

  static Future<void> init() async {
    await Supabase.initialize(
      url: ApiKeys.supabaseUrl,
      anonKey: ApiKeys.supabasePublishableKey,
    );
  }

  /// Helper lấy Public URL từ Storage
  static String getPublicUrl(String bucket, String path) {
    if (path.isEmpty) return "";
    
    // Nếu là link http sẵn thì trả về luôn
    if (path.startsWith("http")) return path;

    try {
      return client.storage.from(bucket).getPublicUrl(path);
    } catch (e) {
      print("--- ERROR getting public URL: $e");
      return "";
    }
  }
}
