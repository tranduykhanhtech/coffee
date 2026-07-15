import 'package:coffee/core/routes/app_pages.dart';
import 'package:coffee/features/profile/controllers/profile_controller.dart';
import 'package:get/get.dart';
import 'package:coffee/core/constants/constants.dart';
import 'package:coffee/core/widgets/app_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileSettingsList extends StatelessWidget {
  const ProfileSettingsList({super.key});

  void _showAddressDialog(BuildContext context) {
    final controller = Get.find<ProfileController>();
    
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(24.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText.medium("Update Delivery Address"),
            SizedBox(height: 16.h),
            TextField(
              controller: controller.addressController,
              decoration: InputDecoration(
                hintText: "Enter your address",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r)),
              ),
              maxLines: 3,
            ),
            SizedBox(height: 24.h),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => controller.updateAddress(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                ),
                child: AppText.medium("Save Address", color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.border.withOpacity(0.1)),
      ),
      child: Column(
        children: [
          _SettingItem(
            icon: "assets/icons/cart.svg",
            title: "My Cart",
            isFirst: true,
            onTap: () => Get.toNamed(Routes.CART),
          ),
          _SettingItem(
            icon: "assets/icons/delivery_location.svg", 
            title: "Delivery Address",
            onTap: () => _showAddressDialog(context),
          ),
          _SettingItem(
            icon: "assets/icons/bank_card.svg", 
            title: "Payment Methods",
            onTap: () => Get.toNamed(Routes.PAYMENT_METHOD),
          ),
          _SettingItem(
            icon: "assets/icons/notification.svg", 
            title: "Orders",
            onTap: () => Get.toNamed(Routes.ORDER_HISTORY),
          ),
          _SettingItem(icon: "assets/icons/setting.svg", title: "Setting"),
          _SettingItem(
            icon: "assets/icons/help.svg",
            title: "Help & Support",
            isLast: true,
          ),
        ],
      ),
    );
  }
}

class _SettingItem extends StatelessWidget {
  final String icon;
  final String title;
  final bool isFirst;
  final bool isLast;
  final VoidCallback? onTap;

  const _SettingItem({
    required this.icon,
    required this.title,
    this.isFirst = false,
    this.isLast = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 62.h,
        padding: EdgeInsets.only(
          top: 16.h,
          bottom: 16.h,
          left: 16.w,
          right: 9.w,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(
            top: isFirst ? Radius.circular(16.r) : Radius.zero,
            bottom: isLast ? Radius.circular(16.r) : Radius.zero,
          ),
          border: Border(
            bottom: isLast
                ? BorderSide.none
                : BorderSide(color: AppColors.border.withOpacity(0.1)),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                color: AppColors.primaryLight.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: AppIcon(icon, size: 25, color: AppColors.primary),
              ),
            ),
            SizedBox(width: 13.w),
            AppText.medium(title),
            const Spacer(),
            const AppIcon("assets/icons/next.svg", color: AppColors.border),
          ],
        ),
      ),
    );
  }
}
