import 'package:coffee/core/constants/constants.dart';
import 'package:coffee/features/orders/controllers/order_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DeliveryToggle extends GetView<OrderController> {
  const DeliveryToggle({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48.h, // Tăng nhẹ chiều cao để padding thoải mái hơn
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: const Color(0xFFEDEDED),
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Row(
        children: [
          // Ô Deliver (Giao hàng) - Luôn nằm bên TRÁI
          Expanded(
            child: Obx(() {
              final bool active = controller.isDeliver.value;
              return GestureDetector(
                onTap: () => controller.setDeliveryMode(true),
                child: Container(
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color: active ? AppColors.primary : Colors.transparent,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Center(
                    child: AppText(
                      "Shop Address",
                      fontSize: 16.sp,
                      fontWeight: active ? FontWeight.bold : FontWeight.normal,
                      color: active ? Colors.white : AppColors.textMain,
                    ),
                  ),
                ),
              );
            }),
          ),
          // Ô Pick Up (Đến lấy) - Luôn nằm bên PHẢI
          Expanded(
            child: Obx(() {
              final bool active = !controller.isDeliver.value;
              return GestureDetector(
                onTap: () => controller.setDeliveryMode(false),
                child: Container(
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color: active ? AppColors.primary : Colors.transparent,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Center(
                    child: AppText(
                      "Pick Up",
                      fontSize: 16.sp,
                      fontWeight: active ? FontWeight.bold : FontWeight.normal,
                      color: active ? Colors.white : AppColors.textMain,
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
