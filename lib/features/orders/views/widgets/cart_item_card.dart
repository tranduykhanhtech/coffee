import 'package:coffee/core/services/cart_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/widgets/app_icon.dart';

class CartItemCard extends StatelessWidget {
  final String productSizeId;
  final String imageUrl;
  final String name;
  final String subName;
  final double price;
  final int quantity;

  const CartItemCard({
    super.key,
    required this.productSizeId,
    required this.imageUrl,
    required this.name,
    required this.subName,
    required this.price,
    required this.quantity,
  });

  @override
  Widget build(BuildContext context) {
    final cartService = Get.find<CartService>();

    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          // Ảnh sản phẩm dạng tròn
          Container(
            width: 64.w,
            height: 64.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage(imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 12.w),
          // Thông tin tên và loại cà phê
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText.medium(name, fontSize: 16.sp),
                AppText(
                  subName,
                  fontSize: 12.sp,
                  color: AppColors.border,
                ),
                SizedBox(height: 4.h),
                // Giá sản phẩm
                AppText.medium("\$ ${price.toStringAsFixed(2)}", fontSize: 16.sp),
              ],
            ),
          ),
          // Các nút hành động: Xóa và Tăng/Giảm số lượng
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Icon thùng rác để xóa sản phẩm khỏi giỏ
              GestureDetector(
                onTap: () => cartService.removeFromCart(productSizeId),
                child: AppIcon(
                  "assets/icons/trash.svg",
                  size: 20,
                  color: AppColors.border,
                ),
              ),
              SizedBox(height: 6.h),
              // Nút bấm điều chỉnh số lượng (+/-)
              Row(
                children: [
                  GestureDetector(
                    onTap: () => cartService.updateQuantity(productSizeId, -1),
                    child: AppIcon("assets/icons/minus.svg", size: 32,),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    child: AppText.medium(quantity.toString(), fontSize: 16.sp),
                  ),
                  GestureDetector(
                    onTap: () => cartService.updateQuantity(productSizeId, 1),
                    child: AppIcon("assets/icons/plus.svg", size: 32,),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

