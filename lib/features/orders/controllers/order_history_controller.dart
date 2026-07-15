import 'package:get/get.dart';
import '../models/order_model.dart';
import '../repository/order_repository.dart';

class OrderHistoryController extends GetxController {
  final OrderRepository repository;
  OrderHistoryController({required this.repository});

  var isLoading = false.obs;
  var orderHistory = <OrderModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchOrderHistory();
  }

  Future<void> fetchOrderHistory() async {
    try {
      final user = repository.currentUser;
      if (user == null) return;

      isLoading.value = true;
      final response = await repository.getOrderHistory(user.id);
      
      final List<OrderModel> history = response
          .map((data) => OrderModel.fromJson(data))
          .toList();
          
      orderHistory.assignAll(history);
    } catch (e) {
      print("--- ERROR fetching order history: $e");
      // Get.snackbar("Lỗi", "Không thể tải lịch sử đơn hàng");
    } finally {
      isLoading.value = false;
    }
  }

  /// Làm mới danh sách
  Future<void> refreshHistory() async {
    await fetchOrderHistory();
  }
}
