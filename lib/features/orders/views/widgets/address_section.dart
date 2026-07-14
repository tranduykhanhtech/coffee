import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/widgets/app_icon.dart';

class AddressSection extends StatelessWidget {
  const AddressSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 94.h,
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: AppColors.primaryLight.withOpacity(0.3),
        borderRadius: BorderRadius.circular(16),
      ),
      child: SizedBox(
        width: double.infinity,
        height: 79.h,
        child: Row(
          children: [
            AppIcon("assets/icons/location.svg", size: 48,),
            SizedBox(width: 12.w),
            // Address Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText.small("Deliver to An Nhon", color: Colors.black,),
                  SizedBox(height: 2.h),
                  AppText.tiny(
                    "289 Nguyen Thai Son, Ho Chi Minh",
                    fontSize: 12.sp,
                    color: AppColors.border,
                    fontWeight: FontWeight.normal,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            SizedBox(width: 8.w),
            // Change button
            AppText(
              "Change",
              fontSize: 15.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.primary,
            ),
          ],
        ),
      )

    );
  }
}
