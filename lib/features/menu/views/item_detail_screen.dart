import 'package:coffee/core/services/auth_service.dart'; // Import AuthService
import 'package:coffee/core/services/favorite_service.dart'; // Import FavoriteService
import 'package:coffee/features/orders/models/cart_item_model.dart';
import 'package:coffee/core/services/cart_service.dart';
import 'package:coffee/core/routes/app_pages.dart';
import 'package:coffee/features/menu/models/product_model.dart';
import 'package:coffee/features/menu/models/product_size_model.dart';
import 'package:coffee/core/constants/constants.dart';
import 'package:coffee/core/widgets/app_bar.dart';
import 'package:coffee/core/widgets/app_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'widgets/detail_widgets/detail_image.dart';
import 'widgets/detail_widgets/detail_info.dart';
import 'widgets/detail_widgets/detail_description.dart';
import 'widgets/detail_widgets/detail_size_selector.dart';
import 'widgets/detail_widgets/detail_bottom_bar.dart';

class ItemDetailScreen extends StatefulWidget {
  const ItemDetailScreen({super.key});

  @override
  State<ItemDetailScreen> createState() => _ItemDetailScreenState();
}

class _ItemDetailScreenState extends State<ItemDetailScreen> {
  // Lấy dữ liệu sản phẩm từ arguments (đã kèm theo danh sách size/giá)
  final ProductModel product = Get.arguments;
  
  // Quản lý giá tiền và size hiện tại dựa trên dữ liệu thật từ DB
  late double currentPrice;
  ProductSizeModel? selectedSize;

  // Lấy FavoriteService để xử lý logic thả tim
  final favoriteService = Get.find<FavoriteService>();

  @override
  void initState() {
    super.initState();
    // Mặc định chọn size đầu tiên trong danh sách lấy được từ Database
    if (product.sizes != null && product.sizes!.isNotEmpty) {
      selectedSize = product.sizes!.first;
      currentPrice = selectedSize!.price ?? product.price ?? 0.0;
    } else {
      currentPrice = product.price ?? 0.0;
    }
  }

  /// Hàm xử lý khi người dùng thay đổi kích thước (S, M, L)
  void _onSizeSelected(ProductSizeModel sizeObj) {
    setState(() {
      selectedSize = sizeObj;
      currentPrice = sizeObj.price ?? product.price ?? 0.0;
    });
  }

  /// Hàm xử lý khi nhấn Buy Now để mang dữ liệu sang trang Order
  void _handleBuyNow() {
    // Check login trước khi thực hiện chức năng mua hàng nhạy cảm (Lazy Login)
    Get.find<AuthService>().protectedAction(() {
      Get.toNamed(
        Routes.ORDER,
        arguments: {
          "product": product,
          "selectedSize": selectedSize,
          "totalPrice": currentPrice,
        },
      );
    });
  }

  /// Hàm xử lý khi nhấn Add to Cart (Lazy Login support)
  void _handleAddToCart() {
    if (selectedSize == null) {
      Get.snackbar("Thông báo", "Vui lòng chọn size");
      return;
    }

    final cartItem = CartItemModel(
      productSizeId: selectedSize!.id!,
      quantity: 1,
      productName: product.productName,
      productSubname: product.productSubname,
      imageUrl: product.productImageUrl,
      price: currentPrice,
    );

    Get.find<CartService>().addToCart(cartItem);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Màu nền được quản lý bởi AppTheme, không set thủ công ở đây
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: AppSizes.screenPadding,
              child: Column(
                children: [
                  // AppBar với tiêu đề Detail và icon trái tim (Yêu thích)
                  Obx(() => AppBarCoffee(
                    title: "Detail",
                    icon: GestureDetector(
                      onTap: () => favoriteService.toggleFavorite(product.id!),
                      child: AppIcon(
                        favoriteService.isFavorite(product.id!) 
                            ? "assets/icons/favorite_active.svg" 
                            : "assets/icons/favorite.svg"
                      ),
                    ),
                  )),
                  
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 24.h),
                          
                          // Ảnh lớn từ URL của sản phẩm
                          DetailImage(imageUrl: product.productImageUrl ?? "assets/images/mocha.png"),
                          
                          SizedBox(height: 16.h),
                          
                          // Thông tin Tên, Loại và Đánh giá
                          DetailInfo(
                            name: product.productName ?? "Unknown",
                            subName: product.productSubname ?? "",
                            rating: 4.8, 
                            reviewCount: 230,
                          ),

                          Divider(color: AppColors.border.withOpacity(0.2)),
                          SizedBox(height: 16.h),
                          
                          // Mô tả chi tiết từ Database
                          DetailDescription(description: product.description ?? "No description available."),
                          
                          SizedBox(height: 20.h),
                          
                          // Widget chọn Size sử dụng dữ liệu động từ quan hệ n-n (products_size)
                          if (product.sizes != null && product.sizes!.isNotEmpty)
                            DetailSizeSelector(
                              availableSizes: product.sizes!,
                              onSizeSelected: _onSizeSelected,
                            ),
                          
                          SizedBox(height: 140.h),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            // Hiển thị giá tiền thực tế tương ứng với size đã được chọn
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: DetailBottomBar(
                price: currentPrice,
                onBuyNow: _handleBuyNow,
                onAddToCart: _handleAddToCart,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
