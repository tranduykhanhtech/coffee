import 'dart:math' as math;

import 'package:coffee/features/menu/controllers/coffee_menu_controller.dart';
import 'package:coffee/features/profile/controllers/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../../core/widgets/app_icon.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    // Inject controllers
    final menuController = Get.find<CoffeeMenuController>();
    // Lấy ProfileController để hiển thị địa chỉ
    final profileController = Get.find<ProfileController>();

    return Container(
      width: double.infinity,
      height: 280.h,
      padding: AppSizes.screenPadding,
      decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: const [
              Color(0xFF111111),
              Color(0xFF313131),
            ],
            stops: const [0.0, 1.0],
            transform: const GradientRotation(241 * math.pi / 180),
          )
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 50.h,),
          AppText.tiny("Location", color: AppColors.border, fontWeight: FontWeight.normal,),
          SizedBox(height: 8.h,),
          Row(
            children: [
              // Sử dụng Obx để cập nhật địa chỉ tự động
              Obx(() => AppText.medium(
                profileController.address.value.isEmpty ? "No Address Set" : profileController.address.value,
                color: const Color(0xFFD8D8D8),
              )),
              //AppIcon("assets/icons/dropdown.svg", size: 14.sp,)
            ],
          ),
          SizedBox(height: 24.h,),
          Row(
            children: [
              _customSearchBar(menuController),
              SizedBox(width: 16.w,),
              const AppIcon("assets/icons/filter.svg", size: 52,),
            ],
          )
        ],
      ),
    );
  }

  Widget _customSearchBar(CoffeeMenuController controller) {
    return Container(
      width: 259.w,
      height: 52.h,
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 16.w, right: 12.w),
            child: const AppIcon("assets/icons/search.svg", size: 20),
          ),
          Expanded(
            child: TextField(
              textAlignVertical: TextAlignVertical.center,
              cursorColor: Colors.grey,
              style: const TextStyle(color: Colors.white, decoration: TextDecoration.none),
              decoration: InputDecoration(
                hintText: "Search coffee",
                hintStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 14.sp,
                ),
                border: InputBorder.none,
                isCollapsed: true,
                contentPadding: EdgeInsets.zero,
              ),
              // Gõ đến đâu search tới đó
              onChanged: (value) => controller.setSearchQuery(value),
            ),
          ),
        ],
      ),
    );
  }
}
