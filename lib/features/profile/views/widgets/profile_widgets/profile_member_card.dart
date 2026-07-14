import 'package:coffee/core/constants/constants.dart';
import 'package:coffee/core/widgets/app_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileMemberCard extends StatelessWidget {
  const ProfileMemberCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 86.h, // h 86
      padding: EdgeInsets.only(
        top: 20.h,
        bottom: 20.h,
        left: 12.w, // pad trái 12
        right: 5.w, // pad phải 5
      ),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(16.r), // bo góc 16
      ),
      child: Row(
        children: [
          // Icon tym: 46x40
          const AppIcon(
            "assets/icons/big_heart.svg",
            size: 40,
            color: Colors.white,
          ),
          SizedBox(width: 7.w), // cách bên phải là 7
          
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Cửa chữ: cỡ medium
                AppText.medium(
                  "Coffee Member · Gold",
                  color: Colors.white,
                ),
                // Chữ phụ: cỡ small, opacity là 50
                AppText.small(
                  "3 more cups to a free drink",
                  color: Colors.white.withOpacity(0.5),
                ),
              ],
            ),
          ),
          
          // Icon mũi tên: 32x32
          const AppIcon(
            "assets/icons/next.svg",
            size: 32,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
