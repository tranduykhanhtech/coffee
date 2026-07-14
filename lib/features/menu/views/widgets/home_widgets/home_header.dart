import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/constants.dart';
import '../../../../../core/widgets/app_icon.dart';

Widget _customSearchBar() {
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
        // Đặt Icon cố định ở phía trước
        Padding(
          padding: EdgeInsets.only(left: 16.w, right: 12.w),
          child: const AppIcon("assets/icons/search.svg", size: 20),
        ),
        // TextField chiếm phần còn lại, bỏ các padding mặc định để không bị lệch
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
              isCollapsed: true, // Ép TextField không chiếm không gian đệm mặc định
              contentPadding: EdgeInsets.zero, // Loại bỏ hoàn toàn padding để căn theo Row
            ),
            onChanged: (value) {},
            onSubmitted: (value) {},
          ),
        ),
      ],
    ),
  );
}

class HomeHeader extends StatelessWidget{
  const HomeHeader({super.key});
  @override
  Widget build(BuildContext context) {
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
            // sử dụng kiến thức về góc radian hồi lớp 12 để xoay góc
            stops:  const [0.0, 1.0],
            // đổi từ độ sang radian và xoay góc
            transform: const GradientRotation(241 * math.pi / 180),
          )
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 50.h,),
          AppText.tiny("Location",color: AppColors.border, fontWeight: FontWeight.normal,),
          SizedBox(height: 8.h,),
          Row(
            children: [
              AppText.medium("An Nhon, Ho Chi Minh", color: Color(0xFFD8D8D8),),
              AppIcon("assets/icons/dropdown.svg", size: 14.sp, )
            ],
          ),
          SizedBox(height: 24.h,),
          Row(
            children: [
              _customSearchBar(),
              SizedBox(width: 16.w,),
              AppIcon("assets/icons/filter.svg", size: 52,),
            ],
          )

        ],
      ),
    );
  }

}