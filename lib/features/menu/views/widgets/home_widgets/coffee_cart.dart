import 'package:coffee/core/widgets/custom_image.dart';
import 'package:coffee/core/services/cart_service.dart';
import 'package:coffee/features/orders/models/cart_item_model.dart';
import 'package:coffee/features/menu/models/product_model.dart';
import 'package:coffee/core/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../../core/widgets/app_icon.dart';

class CoffeeCart extends StatelessWidget {
  final ProductModel product;

  const CoffeeCart({
    super.key,
    required this.product,
  });

  void _handleAddToCart() {
    // Nếu sản phẩm không có size, ta lấy giá mặc định của sản phẩm
    // Tuy nhiên, theo logic DB của ô, giá nằm ở products_size
    // Ở màn hình Home (CoffeeCart), nếu ô muốn thêm nhanh thì thường sẽ lấy size mặc định đầu tiên
    if (product.sizes == null || product.sizes!.isEmpty) {
      Get.snackbar("Thông báo", "Sản phẩm hiện chưa có size để chọn");
      return;
    }

    final defaultSize = product.sizes!.first;

    final cartItem = CartItemModel(
      productId: product.id!, // Bổ sung ID sản phẩm ở đây
      productSizeId: defaultSize.id!,
      quantity: 1,
      productName: product.productName,
      productSubname: product.productSubname,
      imageUrl: product.productImageUrl,
      price: defaultSize.price ?? product.price,
    );

    Get.find<CartService>().addToCart(cartItem);
  }

  @override
  Widget build(BuildContext context) {
    return Material( // Thêm Material để hiệu ứng InkWell hiển thị được
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          Get.toNamed(
            Routes.ITEM_DETAIL,
            arguments: product,
          );
        },
        borderRadius: BorderRadius.circular(16.r),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
          ),
          width: 156.w,
          padding: EdgeInsets.only(left: 8.w, right: 8.w, top: 8.h, bottom: 12.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Ảnh sản phẩm
              CustomImage(
                width: 140.w,
                height: 128.h,
                imageUrl: product.fullImageUrl,
                borderRadius: BorderRadius.circular(12),
              ),
              SizedBox(height: 8.h),
              // Tên món và mô tả phụ
              AppText.medium(
                product.productName ?? "",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              AppText.tiny(
                product.productSubname ?? "",
                color: AppColors.border,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 12.h),
              // Giá và nút thêm (Tách riêng logic click cho nút thêm)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppText(
                    "\$ ${product.price}",
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  // Nút thêm sản phẩm vào giỏ
                  GestureDetector(
                    onTap: _handleAddToCart,
                    child: const AppIcon("assets/icons/add.svg"),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
