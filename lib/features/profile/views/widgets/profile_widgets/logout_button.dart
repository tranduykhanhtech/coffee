import 'package:coffee/core/services/auth_service.dart';
import 'package:get/get.dart';
import 'package:coffee/core/constants/constants.dart';
import 'package:coffee/core/widgets/app_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56.h,
      child: ElevatedButton(
        onPressed: () {
          // Gọi hàm signOut từ AuthService
          Get.find<AuthService>().signOut();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(color: AppColors.border.withOpacity(0.1)),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // icon là 16x16
            const AppIcon(
              "assets/icons/logout.svg",
              size: 16,
              color: Color(0xFF9B1B30),
            ),
            SizedBox(width: 10.w), // cách icon trái là 10
            // "Log Out": cỡ medium, màu 9B1B30
            AppText.medium(
              "Log Out",
              color: const Color(0xFF9B1B30),
            ),
          ],
        ),
      ),
    );
  }
}
