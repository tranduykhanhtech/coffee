import 'package:coffee/core/widgets/custom_image.dart';
import 'package:coffee/core/constants/constants.dart';
import 'package:coffee/core/widgets/app_icon.dart';
import 'package:coffee/features/orders/controllers/order_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class OrderItemCard extends GetView<OrderController> {
  final int index;
  final String name;
  final String subName;
  final String imageUrl;

  const OrderItemCard({
    super.key,
    required this.index,
    required this.name,
    required this.subName,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 54.h,
      child: Row(
        children: [
          // Ảnh sp nhỏ 54x54
          CustomImage(
            width: 54.w,
            height: 54.h,
            imageUrl: imageUrl,
            borderRadius: BorderRadius.circular(12.r),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppText.medium(name),
                SizedBox(height: 4.h),
                AppText.tiny(subName, color: AppColors.border),
              ],
            ),
          ),
          // Bộ nút tăng giảm số lượng (Reactive theo index)
          SizedBox(
            width: 90.w,
            height: 24.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => controller.decrementQuantity(index),
                  child: const AppIcon("assets/icons/minus.svg"),
                ),
                Obx(() => AppText.medium(
                  controller.orderItems[index].quantity.toString(), 
                  fontSize: 14.sp
                )),
                GestureDetector(
                  onTap: () => controller.incrementQuantity(index),
                  child: const AppIcon("assets/icons/plus_white.svg"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
