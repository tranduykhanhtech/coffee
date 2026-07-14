import 'package:coffee/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DeliveryToggle extends StatefulWidget {
  const DeliveryToggle({super.key});

  @override
  State<DeliveryToggle> createState() => _DeliveryToggleState();
}

class _DeliveryToggleState extends State<DeliveryToggle> {
  bool isDeliver = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 43.h, // h: 43
      padding: EdgeInsets.all(4.w), // padding 4 bên là 4
      decoration: BoxDecoration(
        color: const Color(0xFFEDEDED), // màu EDEDED
        borderRadius: BorderRadius.circular(12.r), // bo góc 12
      ),
      child: Row(
        children: [
          // Ô Deliver
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => isDeliver = true),
              child: Container(
                height: 35.h, // 159x35
                decoration: BoxDecoration(
                  color: isDeliver ? AppColors.primary : Colors.transparent,
                  borderRadius: BorderRadius.circular(8.r), // bo 4 góc là 8
                ),
                child: Center(
                  child: AppText(
                    "Deliver",
                    fontSize: 16.sp, // medium
                    fontWeight: isDeliver ? FontWeight.bold : FontWeight.normal,
                    color: isDeliver ? Colors.white : AppColors.textMain,
                  ),
                ),
              ),
            ),
          ),
          // Ô Pick Up
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => isDeliver = false),
              child: Container(
                height: 35.h,
                decoration: BoxDecoration(
                  color: !isDeliver ? AppColors.primary : Colors.transparent,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Center(
                  child: AppText(
                    "Pick Up",
                    fontSize: 16.sp,
                    fontWeight: !isDeliver ? FontWeight.bold : FontWeight.normal,
                    color: !isDeliver ? Colors.white : AppColors.textMain,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
