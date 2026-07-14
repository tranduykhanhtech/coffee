import 'package:coffee/core/services/favorite_service.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../../core/widgets/app_icon.dart';

class FavoriteCard extends StatelessWidget {
  final String productId;
  final String title;
  final String subTitle;
  final String imageUrl;

  const FavoriteCard({
    super.key, 
    required this.productId,
    required this.title, 
    required this.subTitle, 
    required this.imageUrl
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 327.w,
      height: 112.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        children: [
          Container( // bọc ảnh
            width: 87.w,
            height: 80.h,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: DecorationImage(
                    image: AssetImage(imageUrl),
                    fit: BoxFit.cover
                )
            ),
          ),
          SizedBox(width: 12.w,),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText.medium(title, fontSize: 16.sp),
                SizedBox(height: 4.h,),
                AppText.tiny(subTitle, color: AppColors.border),
              ],
            ),
          ),
          GestureDetector(
            onTap: () => Get.find<FavoriteService>().toggleFavorite(productId),
            child: const AppIcon("assets/icons/favorite_active.svg", size: 24),
          ),
        ],
      ),
    );
  }
}
