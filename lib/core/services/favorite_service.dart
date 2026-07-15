import 'package:coffee/core/repository/favorite_repository.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'auth_service.dart';

class FavoriteService extends GetxService {
  final _storage = GetStorage();
  final _repository = Get.find<FavoriteRepository>();
  
  var favoriteProductIds = <String>{}.obs; 
  static const String _favoriteKey = 'local_favorites';

  @override
  void onInit() {
    super.onInit();
    loadFavorites();
  }

  Future<void> loadFavorites() async {
    final user = _repository.currentUser; // Gọi qua Repo
    if (user != null) {
      await fetchFavoritesFromSupabase();
    } else {
      loadFavoritesFromLocal();
    }
  }

  void loadFavoritesFromLocal() {
    final List<dynamic>? stored = _storage.read(_favoriteKey);
    if (stored != null) {
      favoriteProductIds.assignAll(stored.cast<String>());
    }
  }

  Future<void> fetchFavoritesFromSupabase() async {
    try {
      final user = _repository.currentUser;
      if (user == null) return;

      final response = await _repository.fetchFavorites(user.id);
      final List<String> remoteIds = (response as List).map((e) => e['product_id'] as String).toList();
      favoriteProductIds.assignAll(remoteIds);
    } catch (e) {
      print("Error fetching favorites: $e");
    }
  }

  bool isFavorite(String productId) {
    return favoriteProductIds.contains(productId);
  }

  Future<void> toggleFavorite(String productId) async {
    // Ép buộc đăng nhập để test luồng Auth
    Get.find<AuthService>().protectedAction(() async {
      final user = _repository.currentUser;
      if (user == null) return;

      if (favoriteProductIds.contains(productId)) {
        favoriteProductIds.remove(productId);
        // Xóa đồng thời ở DB và cập nhật Local
        await _repository.removeFavorite(user.id, productId);
        _saveToLocal();
      } else {
        favoriteProductIds.add(productId);
        // Thêm đồng thời ở DB và cập nhật Local
        await _repository.addFavorite(user.id, productId);
        _saveToLocal();
      }
    });
  }

  Future<void> syncFavoritesToSupabase() async {
    final user = _repository.currentUser;
    if (user == null || favoriteProductIds.isEmpty) return;

    final List<dynamic>? stored = _storage.read(_favoriteKey);
    if (stored == null || stored.isEmpty) return;

    try {
      for (String productId in stored) {
        await _repository.upsertFavorite(user.id, productId);
      }
      
      await _storage.remove(_favoriteKey);
      await fetchFavoritesFromSupabase();
    } catch (e) {
      print("Sync favorites error: $e");
    }
  }

  void _saveToLocal() {
    _storage.write(_favoriteKey, favoriteProductIds.toList());
  }

  void clearFavorites() {
    favoriteProductIds.clear();
    _storage.remove(_favoriteKey);
  }
}
