import 'package:coffee/core/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileHeader extends StatelessWidget {
  final String name;
  final String email;
  final String avatarUrl;

  const ProfileHeader({
    super.key,
    required this.name,
    required this.email,
    required this.avatarUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Avatar: 60.57x68, bo góc 100
        Container(
          width: 60.57.w,
          height: 68.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            image: DecorationImage(
              image: AssetImage(avatarUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(height: 9.h), // cách bên dưới là 9
        
        // Tên: cỡ medium
        AppText.medium(name),
        
        // Email: cỡ medium, màu border
        AppText.medium(
          email,
          color: AppColors.border,
          fontWeight: FontWeight.normal,
        ),
      ],
    );
  }
}
