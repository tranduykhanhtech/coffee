import 'package:coffee/features/profile/controllers/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/widgets/app_icon.dart';

class AddressSection extends StatelessWidget {
  const AddressSection({super.key});

  @override
  Widget build(BuildContext context) {
    // Tìm ProfileController để lấy dữ liệu địa chỉ thật
    final profileController = Get.find<ProfileController>();

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: AppColors.primaryLight.withAlpha(76), // 0.3 * 255 ≈ 76
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              AppIcon("assets/icons/location.svg", size: 48.w),
              SizedBox(width: 12.w),
              // Address Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(() => AppText.medium(
                      profileController.displayName.value.isEmpty 
                          ? "My Location" 
                          : profileController.displayName.value,
                      fontSize: 16.sp,
                    )),
                    SizedBox(height: 4.h),
                    Obx(() => AppText.small(
                      profileController.address.value.isEmpty
                          ? "Please set your delivery address"
                          : profileController.address.value,
                      color: AppColors.border,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    )),
                  ],
                ),
              ),
              SizedBox(width: 8.w),
              // Change button
              GestureDetector(
                onTap: () => profileController.showEditAddressSheet(),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.r),
                    border: Border.all(color: AppColors.border.withAlpha(100)),
                  ),
                  child: AppText(
                    "Change",
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
