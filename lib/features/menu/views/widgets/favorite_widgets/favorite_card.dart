import 'package:coffee/core/routes/app_pages.dart';
import 'package:coffee/core/services/favorite_service.dart';
import 'package:coffee/features/menu/models/product_model.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/widgets/custom_image.dart';
import '../../../../../core/constants/constants.dart';
import '../../../../../core/widgets/app_icon.dart';

class FavoriteCard extends StatelessWidget {
  final ProductModel product;

  const FavoriteCard({
    super.key, 
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Chuyển sang trang chi tiết khi bấm vào thẻ
        Get.toNamed(
          Routes.ITEM_DETAIL,
          arguments: product,
        );
      },
      child: Container(
        width: 327.w,
        height: 112.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(5), // 0.02 * 255 ≈ 5
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Row(
          children: [
            CustomImage( // bọc ảnh
              width: 87.w,
              height: 80.h,
              imageUrl: product.fullImageUrl,
              borderRadius: BorderRadius.circular(16),
            ),
            SizedBox(width: 12.w,),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText.medium(product.productName ?? "", fontSize: 16.sp),
                  SizedBox(height: 4.h,),
                  AppText.tiny(product.productSubname ?? "", color: AppColors.border),
                ],
              ),
            ),
            GestureDetector(
              onTap: () => Get.find<FavoriteService>().toggleFavorite(product.id!),
              child: const AppIcon("assets/icons/favorite_active.svg", size: 24),
            ),
          ],
        ),
      ),
    );
  }
}
