import 'package:google_sign_in/google_sign_in.dart';
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
  Future<AuthResponse> signUpWithOTP({
    required String email,
    required String password,
    required String userName,
    required String displayName,
  }) async {
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
      'status': 'ACTIVE', 
      'provider': 'local', 
    });
  }

  /// 5. Đăng nhập với Email và Password (Supabase Auth)
  Future<AuthResponse> signIn({
    required String email,
    required String password,
  }) async {
    final hashedPassword = AppUtils.hashPassword(password);

    return await _supabase.auth.signInWithPassword(
      email: email,
      password: hashedPassword,
    );
  }

  /// 5.1 Đăng nhập bằng Google (Native Flow)
  Future<AuthResponse?> signInWithGoogle() async {
    try {
      const webClientId = '40724827883-s3temucicgv4it88dhtodo9n1kmfjedm.apps.googleusercontent.com';
      
      // 1. Khởi tạo Instance (Dùng .instance thay vì constructor mới theo bản 7.2+)
      final googleSignIn = GoogleSignIn.instance;
      
      // 2. Gọi initialize TRƯỚC KHI dùng các hàm khác
      await googleSignIn.initialize(
        clientId: webClientId,
        serverClientId: webClientId, // Bắt buộc phải có trên Android để trao đổi Token
      );
      
      // 3. Thử đăng nhập nhẹ (restore session cũ nếu có)
      GoogleSignInAccount? googleUser = await googleSignIn.attemptLightweightAuthentication();
      
      // 4. Nếu chưa có, thực hiện đăng nhập tương tác (hiện popup)
      googleUser ??= await googleSignIn.authenticate();

      // 5. Lấy Authentication (ID Token)
      final GoogleSignInAuthentication googleAuth = googleUser.authentication;
      final String? idToken = googleAuth.idToken;

      // 6. Lấy Authorization (Access Token) từ authorizationClient
      final GoogleSignInClientAuthorization? authz = await googleUser.authorizationClient.authorizationForScopes([
        'email',
        'https://www.googleapis.com/auth/userinfo.profile',
      ]);
      final String? accessToken = authz?.accessToken;

      if (idToken == null) {
        throw 'Không lấy được ID Token từ Google';
      }

      return await _supabase.auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: idToken,
        accessToken: accessToken,
      );
    } catch (e) {
      print("--- ERROR signInWithGoogle: $e");
      rethrow;
    }
  }

  /// 6. Đăng xuất khỏi hệ thống
  Future<void> signOut() async {
    await _supabase.auth.signOut();
  }
}
