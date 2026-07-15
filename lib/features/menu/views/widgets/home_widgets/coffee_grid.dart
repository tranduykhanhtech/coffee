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
      if (controller.isLoading.value) {
        return const Center(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: CircularProgressIndicator(),
          ),
        );
      }

      final filteredList = controller.filteredProductList;

      if (filteredList.isEmpty) {
        return const Center(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Text("No products available"),
          ),
        );
      }

      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        itemCount: (filteredList.length / 2).ceil(),
        itemBuilder: (context, index) {
          int firstIndex = index * 2;
          int secondIndex = firstIndex + 1;

          return Padding(
            padding: EdgeInsets.only(bottom: 24.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CoffeeCart(product: filteredList[firstIndex]),
                
                if (secondIndex < filteredList.length)
                  CoffeeCart(product: filteredList[secondIndex])
                else
                  SizedBox(width: 156.w),
              ],
            ),
          );
        },
      );
    });
  }
}
