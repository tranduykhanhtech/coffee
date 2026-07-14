import 'package:coffee/core/constants/constants.dart';
import 'package:coffee/core/widgets/app_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppBarCoffee extends StatelessWidget {
  final String title;
  final Widget? icon; // Dùng Widget để linh hoạt (có thể là AppIcon hoặc AppText như "Read all")

  const AppBarCoffee({
    super.key,
    required this.title,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(height: 24.h,),
        SizedBox(
          width: double.infinity,
          height: 44.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Nút quay lại: Khi bấm vào sẽ quay về trang trước đó trong stack điều hướng
              GestureDetector(
                onTap: () => Navigator.maybePop(context),
                child: const AppIcon("assets/icons/back.svg"),
              ),

              // Tiêu đề của màn hình
              AppText.medium(title),

              // Widget tùy chỉnh bên phải (nếu không có thì để trống để giữ layout cân đối)
              SizedBox(
                width: 44.w,
                height: 44.h,
                child: Center(child: icon),
              )
            ],
          ),
        )
      ],
    );
  }
}
