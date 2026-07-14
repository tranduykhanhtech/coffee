import 'package:coffee/core/utils.dart'; // Import AppUtils để dùng hàm băm
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepository {
  final _supabase = Supabase.instance.client;

  /// 1. Kiểm tra Email hoặc Username đã tồn tại trong hệ thống chưa
  Future<bool> checkUserExists(String email, String userName) async {
    final response = await _supabase
        .from('users')
        .select('id')
        .or('email.eq.$email,user_name.eq.$userName')
        .maybeSingle();
    
    return response != null;
  }

  /// 2. Gửi OTP đăng ký tài khoản (Dùng Supabase Auth)
  /// Trả về AuthResponse để kiểm tra xem có cần verify hay không
  Future<AuthResponse> signUpWithOTP({
    required String email,
    required String password,
    required String userName,
    required String displayName,
  }) async {
    // Băm mật khẩu bằng SHA-256 theo yêu cầu bảo mật
    final hashedPassword = AppUtils.hashPassword(password);

    return await _supabase.auth.signUp(
      email: email,
      password: hashedPassword,
      data: {
        'user_name': userName, 
        'display_name': displayName,
      },
    );
  }

  /// 3. Xác thực OTP và hoàn tất đăng ký
  Future<AuthResponse> verifyOTP({
    required String email,
    required String token,
  }) async {
    return await _supabase.auth.verifyOTP(
      email: email,
      token: token,
      type: OtpType.signup,
    );
  }

  /// Gửi lại mã OTP
  Future<void> resendOTP({required String email}) async {
    await _supabase.auth.resend(
      type: OtpType.signup,
      email: email,
    );
  }

  /// 4. Tạo bản ghi trong bảng public.users (Thủ công)
  Future<void> createPublicUser({
    required String id,
    required String email,
    required String userName,
    required String displayName,
  }) async {
    await _supabase.from('users').insert({
      'id': id,
      'email': email,
      'user_name': userName,
      'display_name': displayName,
      'status': 'ACTIVE', // Gán cứng Enum để tránh lỗi NOT NULL
      'provider': 'local', // Gán cứng để tránh lỗi NOT NULL
    });
  }

  /// 5. Đăng nhập với Email và Password (Supabase Auth)
  /// Phù hợp với Sequence Diagram: Validate credentials -> Return JWT/Session
  Future<AuthResponse> signIn({
    required String email,
    required String password,
  }) async {
    // Băm mật khẩu khách nhập vào để so khớp với bản đã băm trên DB
    final hashedPassword = AppUtils.hashPassword(password);

    return await _supabase.auth.signInWithPassword(
      email: email,
      password: hashedPassword,
    );
  }

  /// 6. Đăng xuất khỏi hệ thống
  Future<void> signOut() async {
    await _supabase.auth.signOut();
  }
}
