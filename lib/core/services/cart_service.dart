import 'package:coffee/core/repository/cart_repository.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../features/orders/models/cart_item_model.dart';

class CartService extends GetxService {
  final _storage = GetStorage();
  final _repository = Get.find<CartRepository>();
  
  var cartItems = <CartItemModel>[].obs;
  static const String _cartKey = 'local_cart';

  @override
  void onInit() {
    super.onInit();
    loadCart();
  }

  // Tải giỏ hàng tùy theo trạng thái login
  Future<void> loadCart() async {
    final user = _repository.currentUser; // Gọi qua Repo
    if (user != null) {
      await fetchCartFromSupabase();
    } else {
      loadCartFromLocal();
    }
  }

  // Lấy từ Local Storage (Guest)
  void loadCartFromLocal() {
    final List<dynamic>? storedCart = _storage.read(_cartKey);
    if (storedCart != null) {
      cartItems.assignAll(storedCart.map((e) => CartItemModel.fromJson(e)).toList());
    }
  }

  // Lấy từ Supabase (User)
  Future<void> fetchCartFromSupabase() async {
    try {
      final user = _repository.currentUser;
      if (user == null) return;

      final response = await _repository.fetchCartItems();

      final List<CartItemModel> remoteItems = (response as List).map((item) {
        final productSize = item['product_size'];
        final product = productSize['product'];
        return CartItemModel(
          productSizeId: item['product_size_id'],
          quantity: item['quantity'],
          productName: product['product_name'],
          productSubname: product['product_subname'],
          imageUrl: product['product_image_url'],
          price: (productSize['price'] as num).toDouble(),
        );
      }).toList();

      cartItems.assignAll(remoteItems);
    } catch (e) {
      Get.snackbar("Lỗi", "Không thể tải giỏ hàng: ${e.toString()}");
    }
  }

  // Thêm vào giỏ hàng
  Future<void> addToCart(CartItemModel newItem) async {
    final user = _repository.currentUser;
    
    // Kiểm tra xem item đã có trong list chưa
    int index = cartItems.indexWhere((item) => item.productSizeId == newItem.productSizeId);

    if (index != -1) {
      // Nếu có rồi thì tăng số lượng
      final updatedItem = cartItems[index].copyWith(quantity: cartItems[index].quantity + newItem.quantity);
      cartItems[index] = updatedItem;
    } else {
      cartItems.add(newItem);
    }

    if (user != null) {
      // Lưu lên Supabase nếu đã login
      await _repository.upsertCartItem(user.id, newItem.productSizeId, cartItems.firstWhere((element) => element.productSizeId == newItem.productSizeId).quantity);
    } else {
      // Lưu local nếu là guest
      _saveCartToLocal();
    }
    Get.snackbar("Thành công", "Đã thêm vào giỏ hàng");
  }

  // Đồng bộ local sang Supabase sau khi login
  Future<void> syncLocalCartToSupabase() async {
    final user = _repository.currentUser;
    if (user == null || cartItems.isEmpty) return;

    final List<dynamic>? storedCart = _storage.read(_cartKey);
    if (storedCart == null || storedCart.isEmpty) return;

    try {
      for (var itemJson in storedCart) {
        final item = CartItemModel.fromJson(itemJson);
        await _repository.upsertCartItem(user.id, item.productSizeId, item.quantity);
      }
      
      // Xóa local sau khi đồng bộ xong
      await _storage.remove(_cartKey);

      // Tải lại toàn bộ giỏ hàng từ server để đảm bảo data chuẩn nhất
      await fetchCartFromSupabase();
      
      Get.snackbar("Đồng bộ", "Giỏ hàng của bạn đã được cập nhật");
    } catch (e) {
      print("Sync error: $e");
    }
  }

  void _saveCartToLocal() {
    _storage.write(_cartKey, cartItems.map((e) => e.toJson()).toList());
  }

  Future<void> updateQuantity(String productSizeId, int delta) async {
    int index = cartItems.indexWhere((item) => item.productSizeId == productSizeId);
    if (index != -1) {
      int newQuantity = cartItems[index].quantity + delta;
      if (newQuantity <= 0) {
        await removeFromCart(productSizeId);
      } else {
        cartItems[index] = cartItems[index].copyWith(quantity: newQuantity);
        final user = _repository.currentUser;
        if (user != null) {
          await _repository.upsertCartItem(user.id, productSizeId, newQuantity);
        } else {
          _saveCartToLocal();
        }
      }
    }
  }

  Future<void> removeFromCart(String productSizeId) async {
    cartItems.removeWhere((item) => item.productSizeId == productSizeId);
    final user = _repository.currentUser;
    if (user != null) {
      await _repository.removeCartItem(user.id, productSizeId);
    } else {
      _saveCartToLocal();
    }
  }

  void clearCart() {
    cartItems.clear();
    _storage.remove(_cartKey);
  }

  double get subtotal => cartItems.fold(0, (sum, item) => sum + ((item.price ?? 0) * item.quantity));
  double get deliveryFee => cartItems.isEmpty ? 0.0 : 1.0;
  double get totalPayment => subtotal + deliveryFee;
}
