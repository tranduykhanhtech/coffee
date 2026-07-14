import 'package:coffee/core/constants/constants.dart';
import 'package:coffee/core/widgets/app_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DiscountCard extends StatelessWidget {
  const DiscountCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56.h, // h: 56
      padding: EdgeInsets.all(16.w), // padding 4 mặt là 16
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r), // bo góc 16
        border: Border.all(color: AppColors.border.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          const AppIcon("assets/icons/discount.svg", size: 20), // icon 20x20
          SizedBox(width: 16.w), // cách chữ 16
          AppText.medium("1 Discount is Applied"),
          const Spacer(),
          const AppIcon("assets/icons/next.svg", size: 20), // icon 20x20
        ],
      ),
    );
  }
}
