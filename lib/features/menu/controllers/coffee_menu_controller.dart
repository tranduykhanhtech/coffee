import 'package:coffee/features/menu/repository/coffee_menu_repository.dart';
import 'package:get/get.dart';

import '../models/product_model.dart';

class CoffeeMenuController extends GetxController{
  final CoffeeMenuRepository repository;
  CoffeeMenuController({required this.repository});

  var isLoading = false.obs;
  var productList = <ProductModel>[].obs;
  
  // Search and Filter logic
  var searchQuery = "".obs;
  var selectedCategory = "All Coffee".obs;
  var categoryList = <String>["All Coffee"].obs;

  @override
  void onInit() {
    super.onInit();
    getAllproducts();
  }

  // Lọc sản phẩm dựa trên search và category
  List<ProductModel> get filteredProductList {
    return productList.where((product) {
      final name = (product.productName ?? "").toLowerCase().trim();
      final search = searchQuery.value.trim().toLowerCase();
      final matchesSearch = search.isEmpty || name.contains(search);
      
      final category = (product.categoryName ?? "").trim().toLowerCase();
      final selected = selectedCategory.value.trim().toLowerCase();
      
      // So sánh không phân biệt hoa thường và trim khoảng trắng
      final matchesCategory = selected == "all coffee" || category == selected;

      return matchesSearch && matchesCategory;
    }).toList();
  }

  Future<void> getAllproducts() async {
    try {
      isLoading.value = true;
      final data = await repository.getAllProducts();
      
      productList.assignAll(data);
      updateCategories(data);
    }
    catch (e) {
      print("--- ERROR IN CONTROLLER: $e");
      Get.snackbar('Error', 'Failed to load products: ${e.toString()}');
    }
    finally {
      isLoading.value = false;
    }
  }

  void updateCategories(List<ProductModel> products) {
    // Trích xuất danh sách category duy nhất từ sản phẩm
    final categories = products
        .map((p) => p.categoryName?.trim())
        .where((name) => name != null && name!.isNotEmpty)
        .cast<String>()
        .toSet()
        .toList();
    
    // Sắp xếp alphabet cho đẹp
    categories.sort((a, b) => a.compareTo(b));
    
    categoryList.assignAll(["All Coffee", ...categories]);
  }

  void setSearchQuery(String query) {
    searchQuery.value = query;
  }

  void setCategory(String category) {
    selectedCategory.value = category;
  }

  ProductModel? getProductById(String id) {
    try {
      return productList.firstWhere((p) => p.id == id);
    } catch (e) {
      return null;
    }
  }
}
