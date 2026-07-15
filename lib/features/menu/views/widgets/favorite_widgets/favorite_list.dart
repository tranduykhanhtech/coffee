import 'package:coffee/core/services/favorite_service.dart';
import 'package:coffee/features/menu/controllers/coffee_menu_controller.dart';
import 'package:coffee/features/menu/views/widgets/favorite_widgets/favorite_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../core/constants/constants.dart';

class FavoriteList extends StatelessWidget{
  const FavoriteList({super.key});

  @override
  Widget build(BuildContext context) {
    final favoriteService = Get.find<FavoriteService>();
    final menuController = Get.find<CoffeeMenuController>();

    return Obx(() {
      final favoriteIds = favoriteService.favoriteProductIds.toList();

      if (favoriteIds.isEmpty) {
        return Center(
          child: Padding(
            padding: EdgeInsets.only(top: 100.h),
            child: AppText.medium("Chưa có món yêu thích nào"),
          ),
        );
      }

      return Wrap(
        runSpacing: 14.h,
        children: favoriteIds.map((id) {
          final product = menuController.getProductById(id);
          if (product == null) return const SizedBox.shrink();

          return FavoriteCard(
            product: product,
          );
        }).toList(),
      );
    });
  }
}
