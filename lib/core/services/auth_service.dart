import 'package:coffee/features/auth/repository/auth_repository.dart'; // Import AuthRepository
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

  bool get isLoggedIn => _supabase.auth.currentSession != null;

  @override
  void onInit() {
    super.onInit();
    _supabase.auth.onAuthStateChange.listen((data) async {
      final AuthChangeEvent event = data.event;
      final Session? session = data.session;

      if (event == AuthChangeEvent.signedIn || event == AuthChangeEvent.tokenRefreshed) {
        if (session != null) {
          _storage.write(_sessionKey, session.toJson());
          
          if (event == AuthChangeEvent.signedIn) {
            Get.find<CartService>().syncLocalCartToSupabase();
            Get.find<FavoriteService>().syncFavoritesToSupabase();
          }
        }
      } else if (event == AuthChangeEvent.signedOut) {
        _storage.remove(_sessionKey);
        Get.find<CartService>().clearCart(); 
        Get.find<FavoriteService>().clearFavorites();
      }
    });
  }

  void protectedAction(void Function() action) {
    if (isLoggedIn) {
      action();
    } else {
      Get.snackbar(
        "Yêu cầu đăng nhập",
        "Vui lòng đăng nhập để sử dụng tính năng này",
        snackPosition: SnackPosition.BOTTOM,
      );
      Get.toNamed(Routes.LOGIN);
    }
  }

  /// Logout sạch sẽ thông qua Repository
  Future<void> signOut() async {
    await _authRepo.signOut(); // Gọi qua Repo thay vì chọc thẳng Client
    Get.offAllNamed(Routes.LOGIN);
  }
}
