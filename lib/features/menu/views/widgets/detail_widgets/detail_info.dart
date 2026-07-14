import 'package:coffee/core/constants/constants.dart';
import 'package:coffee/core/widgets/app_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailInfo extends StatelessWidget {
  final String name;
  final String subName;
  final double rating;
  final int reviewCount;

  const DetailInfo({
    super.key,
    required this.name,
    required this.subName,
    required this.rating,
    required this.reviewCount,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100.h, // Chiều cao khung theo yêu cầu
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Bên trái: Tên, loại và rating
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppText.medium(
                  maxLines: 1, // chống chế tạm, do 1 số sản phẩm có chữ dài
                  name,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600, // semibold
                ),
                SizedBox(height: 4.h), // cách chữ bên dưới 4
                AppText.tiny(subName, color: AppColors.border),
                Row(
                  children: [
                    AppIcon("assets/icons/rate_star.svg"),
                    SizedBox(width: 4.w),
                    AppText.medium(
                      rating.toString(),
                      fontSize: 16.sp,
                    ),
                    SizedBox(width: 4.w),
                    AppText.small("($reviewCount)", color: AppColors.border),
                  ],
                ),
              ],
            ),
          ),
          
          // Bên phải: Các icon 44x44
          Row(
            children: [
              _IconBox(iconPath: "assets/icons/noti_delivery.svg"), // icon tự thêm
              SizedBox(width: 7.w), // cách nhau
              _IconBox(iconPath: "assets/icons/noti_cart.svg"),
              SizedBox(width: 7.w),
              _IconBox(iconPath: "assets/icons/favorite_active.svg"),
            ],
          ),
        ],
      ),
    );
  }
}

class _IconBox extends StatelessWidget {
  final String iconPath;
  const _IconBox({required this.iconPath});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44.w,
      height: 44.w,
      decoration: BoxDecoration(
        color: const Color(0xFFEDEDED),
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Center(
        child: AppIcon(iconPath, size: 24),
      ),
    );
  }
}
