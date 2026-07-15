import 'package:coffee/features/menu/controllers/coffee_menu_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../core/constants/constants.dart';
import 'category_item.dart';

class CategorySelector extends GetView<CoffeeMenuController> {
  const CategorySelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppSizes.screenPadding,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Obx(() => Row(
          spacing: 16.w,
          children: controller.categoryList.map((category) {
            return GestureDetector(
              onTap: () => controller.setCategory(category),
              child: CategoryItem(
                category,
                controller.selectedCategory.value == category,
              ),
            );
          }).toList(),
        )),
      ),
    );
  }
}
