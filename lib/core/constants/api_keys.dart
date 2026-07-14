import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiKeys {
  // Lấy data từ file .env, nếu không tìm thấy thì gán chuỗi rỗng để tránh lỗi null
  static String get supabaseUrl => dotenv.env['SUPABASE_URL'] ?? '';

  static String get supabasePublishableKey => dotenv.env['SUPABASE_PUBLISHABLE_KEY'] ?? '';
}