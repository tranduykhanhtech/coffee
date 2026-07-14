import 'package:coffee/core/constants.dart';
import 'package:coffee/core/widgets/app_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderItemCard extends StatelessWidget {
  final String name;
  final String subName;
  final String imageUrl;

  const OrderItemCard({
    super.key,
    required this.name,
    required this.subName,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 54.h, // h: 54
      child: Row(
        children: [
          // Ảnh sp nhỏ 54x54
          Container(
            width: 54.w,
            height: 54.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              image: DecorationImage(
                image: AssetImage(imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 16.w), // cách ảnh 16
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppText.medium(name),
                SizedBox(height: 4.h), // cách ở trên 4
                AppText.tiny(subName, color: AppColors.border),
              ],
            ),
          ),
          // Bộ nút thêm bớt (90x24)
          SizedBox(
            width: 90.w,
            height: 24.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //const _QtyIcon(icon: Icons.remove),
                AppIcon("assets/icons/minus.svg"),
                AppText.medium("1", fontSize: 14.sp), // số 1 ở giữa
                AppIcon("assets/icons/plus_white.svg"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

