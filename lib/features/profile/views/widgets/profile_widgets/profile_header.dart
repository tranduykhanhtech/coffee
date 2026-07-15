import 'package:coffee/core/constants/constants.dart';
import 'package:coffee/core/widgets/custom_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileHeader extends StatelessWidget {
  final String name;
  final String email;
  final String? avatarUrl;

  const ProfileHeader({
    super.key,
    required this.name,
    required this.email,
    this.avatarUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Avatar: 60.57x68, bo góc 100
        CustomImage(
          width: 60.57.w,
          height: 68.h,
          imageUrl: avatarUrl,
          shape: BoxShape.circle,
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
