import 'package:coffee/features/auth/repository/auth_repository.dart'; // Import AuthRepository
import 'package:coffee/features/profile/controllers/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'cart_service.dart';
import 'favorite_service.dart';
import '../routes/app_pages.dart';

class AuthService extends GetxService {
  final _storage = GetStorage();
  final _supabase = Supabase.instance.client;
  final _authRepo = Get.find<AuthRepository>(); // Tìm Repo để sử dụng

  static const String _sessionKey = 'user_session';

  final Rxn<Session> _currentSession = Rxn<Session>();
  bool get isLoggedIn => _currentSession.value != null;

  @override
  void onInit() {
    super.onInit();
    // Khởi tạo session hiện tại
    _currentSession.value = _supabase.auth.currentSession;

    _supabase.auth.onAuthStateChange.listen((data) async {
      final AuthChangeEvent event = data.event;
      final Session? session = data.session;

      // Cập nhật session reactive
      _currentSession.value = session;

      if (event == AuthChangeEvent.signedIn || event == AuthChangeEvent.tokenRefreshed) {
        if (session != null) {
          _storage.write(_sessionKey, session.toJson());
          
          if (event == AuthChangeEvent.signedIn) {
            // Xử lý đồng bộ user sang public.users nếu đăng nhập qua Social (Google)
            await _syncUserToPublic(session.user);

            Get.find<CartService>().syncLocalCartToSupabase();
            Get.find<FavoriteService>().syncFavoritesToSupabase();
            
            // Cập nhật thông tin profile của tài khoản mới
            if (Get.isRegistered<ProfileController>()) {
              Get.find<ProfileController>().fetchUserData();
            }
          }
        }
      } else if (event == AuthChangeEvent.signedOut) {
        _storage.remove(_sessionKey);
        Get.find<CartService>().clearCart(); 
        Get.find<FavoriteService>().clearFavorites();
        
        // Xóa sạch thông tin profile khi logout
        if (Get.isRegistered<ProfileController>()) {
          Get.find<ProfileController>().clearData();
        }
      }
    });
  }

  void protectedAction(void Function() action) {
    if (isLoggedIn) {
      action();
    } else {
      Get.snackbar(
        "Login Required",
        "Please login to use this feature",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.white.withOpacity(0.9),
        colorText: Colors.black,
        margin: const EdgeInsets.all(15),
        borderRadius: 15,
        icon: const Icon(Icons.lock_outline, color: Colors.orange),
        duration: const Duration(seconds: 3),
      );
      Get.toNamed(Routes.LOGIN);
    }
  }

  /// Logout sạch sẽ thông qua Repository
  Future<void> signOut() async {
    await _authRepo.signOut(); // Gọi qua Repo thay vì chọc thẳng Client
    Get.offAllNamed(Routes.LOGIN);
  }

  /// Đồng bộ thông tin user từ Auth sang bảng public.users (Dành cho Google/Social Login)
  Future<void> _syncUserToPublic(User user) async {
    try {
      // 1. Kiểm tra xem user đã tồn tại trong public.users chưa
      final existingUser = await _supabase
          .from('users')
          .select('id')
          .eq('id', user.id)
          .maybeSingle();

      if (existingUser == null) {
        // 2. Nếu chưa có, tạo bản ghi mới dựa trên metadata từ Google
        final String email = user.email ?? "";
        final String displayName = user.userMetadata?['full_name'] ?? user.userMetadata?['name'] ?? "User";
        final String avatarUrl = user.userMetadata?['avatar_url'] ?? "";
        
        // Tạo username mặc định từ email (ví dụ: lamtu@gmail.com -> lamtu)
        final String userName = email.split('@')[0];

        await _supabase.from('users').insert({
          'id': user.id,
          'email': email,
          'user_name': userName,
          'display_name': displayName,
          'avatar_url': avatarUrl,
          'status': 'ACTIVE',
          'provider': user.appMetadata['provider'] ?? 'google',
        });
        print("--- DEBUG: Sync Google User to Public.Users success ---");
      }
    } catch (e) {
      print("--- ERROR syncing user to public: $e");
    }
  }
}
