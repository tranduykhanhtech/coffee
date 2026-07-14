import 'package:coffee/features/menu/controllers/coffee_menu_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'coffee_cart.dart';

class CoffeeGrid extends GetView<CoffeeMenuController> {
  const CoffeeGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // Hiển thị vòng xoay khi đang tải dữ liệu
      if (controller.isLoading.value) {
        return const Center(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: CircularProgressIndicator(),
          ),
        );
      }

      // Thông báo nếu danh sách trống
      if (controller.productList.isEmpty) {
        return const Center(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Text("No products available"),
          ),
        );
      }

      // Sử dụng ListView.builder thay cho Wrap theo yêu cầu
      return ListView.builder(
        shrinkWrap: true, // Quan trọng: Cho phép ListView nằm trong SingleChildScrollView
        physics: const NeverScrollableScrollPhysics(), // Để trang Home quản lý việc cuộn
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        itemCount: (controller.productList.length / 2).ceil(), // Chia đôi danh sách để làm grid thủ công
        itemBuilder: (context, index) {
          int firstIndex = index * 2;
          int secondIndex = firstIndex + 1;

          return Padding(
            padding: EdgeInsets.only(bottom: 24.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Thẻ sản phẩm thứ nhất
                CoffeeCart(product: controller.productList[firstIndex]),
                
                // Thẻ sản phẩm thứ hai (nếu có)
                if (secondIndex < controller.productList.length)
                  CoffeeCart(product: controller.productList[secondIndex])
                else
                  SizedBox(width: 156.w), // Giữ chỗ nếu hàng chỉ có 1 phần tử
              ],
            ),
          );
        },
      );
    });
  }
}
