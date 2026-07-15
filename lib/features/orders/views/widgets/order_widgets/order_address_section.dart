import 'package:coffee/core/constants/constants.dart';
import 'package:coffee/core/widgets/app_icon.dart';
import 'package:coffee/features/orders/controllers/order_controller.dart';
import 'package:coffee/features/profile/controllers/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class OrderAddressSection extends GetView<OrderController> {
  const OrderAddressSection({super.key});

  @override
  Widget build(BuildContext context) {
    final profileController = Get.find<ProfileController>();

    return Obx(() {
      final bool isDeliver = controller.isDeliver.value;

      return Container(
        constraints: BoxConstraints(minHeight: 100.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Theo yêu cầu: Deliver hiện địa chỉ quán, Pickup hiện địa chỉ giao đến
            if (isDeliver) ...[
              AppText.medium("Shop Address", color: Colors.black),
              SizedBox(height: 16.h),
              AppText.tiny(
                "280 An Nhon, Ho Chi Minh", // Địa chỉ quán
                fontWeight: FontWeight.normal,
                color: AppColors.border,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ] else ...[
              AppText.medium("Pickup Address", color: Colors.black),
              SizedBox(height: 16.h),
              // Pickup hiện tên và địa chỉ người dùng
              AppText(
                profileController.displayName.value.isEmpty
                    ? "My Name"
                    : profileController.displayName.value,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
              SizedBox(height: 4.h),
              AppText.tiny(
                profileController.address.value.isEmpty 
                    ? "Please set your delivery address" 
                    : profileController.address.value,
                fontWeight: FontWeight.normal,
                color: AppColors.border,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 12.h),
              Row(
                children: [
                  GestureDetector(
                    onTap: () => profileController.showEditAddressSheet(),
                    child: const _AddressButton(
                      label: "Edit Address",
                      iconPath: "assets/icons/edit_addr.svg",
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      );
    });
  }
}

class _AddressButton extends StatelessWidget {
  final String label;
  final String iconPath;

  const _AddressButton({
    required this.label,
    required this.iconPath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 12.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.border, width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppIcon(iconPath, size: 14),
          SizedBox(width: 4.w),
          AppText.tiny(label, fontWeight: FontWeight.normal, color: Colors.black,),
        ],
      ),
    );
  }
}
