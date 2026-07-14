import 'package:coffee/features/menu/repository/coffee_menu_repository.dart';
import 'package:get/get.dart';

import '../models/product_model.dart';

class CoffeeMenuController extends GetxController{
  // cục này là DI
  // trông không khác gì DI bên JAVA hay .NET (C#)
  final CoffeeMenuRepository repository;
  CoffeeMenuController({required this.repository}); // constructor
  ///////////////////////////////////////////

  // --- QUẢN LÝ TRẠNG THÁI (STATE) ---
  // Thêm .obs để GetX theo dõi. Khi biến này đổi, UI sẽ tự vẽ lại.
  var isLoading = false.obs;
  var productList = <ProductModel>[].obs;

  @override
  void onInit() {
    super.onInit();

    // vừa vào màn hình phát là load dữ liệu ngay
    getAllproducts();
  }

  // lấy tất cả products
  Future<void> getAllproducts() async {
    try {
      isLoading.value = true; // bật cái loading quay mòng mòng

      final data = await repository.getAllProducts();
      productList.assignAll(data); // đưa data vào biến state
    }
    catch (e) {
      Get.snackbar('no product found', e.toString()); // popup hiển thị lỗi nếu có lỗi xảy ra
    }
    finally {
      isLoading.value = false; // tắt cái xoay mòng mòng
    }
  }

  // Tìm product theo ID (để hiển thị danh sách yêu thích)
  ProductModel? getProductById(String id) {
    try {
      return productList.firstWhere((p) => p.id == id);
    } catch (e) {
      return null;
    }
  }
}
