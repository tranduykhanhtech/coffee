import 'package:coffee/core/constants/constants.dart';
import 'package:coffee/core/widgets/app_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddCardButton extends StatelessWidget {
  const AddCardButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 314.w,
      height: 64.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: AppColors.border.withOpacity(0.3),
          width: 2, // viền là 2
        ),
      ),
      child: Stack(
        children: [
          // Vẽ dash border giả lập bằng CustomPaint nếu cần, ở đây dùng nét đứt đơn giản
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const AppIcon("assets/icons/add_card.svg", size: 20), // icon 20x20
                SizedBox(width: 7.w), // cách icon là 7
                AppText(
                  "Add New Card",
                  fontSize: 14.sp, // small
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
// Chú thích: Để làm border dash chuẩn có thể dùng package 'dotted_border'
