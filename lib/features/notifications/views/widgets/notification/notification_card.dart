import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/constants.dart';
import '../../../../../core/widgets/app_icon.dart';

class NotificationCard extends StatelessWidget {
  final String title;
  final String description;
  final String time;
  final String iconPath;
  final bool isUnread;

  const NotificationCard({
    super.key,
    required this.title,
    required this.description,
    required this.time,
    required this.iconPath,
    this.isUnread = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 325.w,
      height: 131.h,
      padding: EdgeInsets.symmetric(horizontal: 12.w ,vertical:  16.h),
      decoration: BoxDecoration(
        color: isUnread ? AppColors.background : Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon Placeholder (40x40)
              Container(
                width: 40.w,
                height: 40.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primaryLight
                ),
                child: AppIcon(iconPath, size: 25,),
              ),
              SizedBox(width: 12.w),
              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText.medium(
                      title,
                      fontWeight: FontWeight.w600, // semi bold as requested
                    ),
                    SizedBox(height: 4.h),
                    AppText.tiny(
                      description,
                      color: AppColors.border,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Spacer(),
                    AppText.small(
                      time,
                      color: AppColors.border,
                    ),
                  ],
                ),
              ),
            ],
          ),
          // Unread dot (10x10)
          if (isUnread)
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                width: 10.w,
                height: 10.w,
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
