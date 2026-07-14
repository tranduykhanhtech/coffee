import 'package:coffee/core/constants/constants.dart';
import 'package:coffee/core/widgets/app_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileSettingsList extends StatelessWidget {
  const ProfileSettingsList({super.key});

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
            title: "My Orders",
            isFirst: true,
          ),
          _SettingItem(icon: "assets/icons/delivery_location.svg", title: "Delivery Address"),
          _SettingItem(icon: "assets/icons/bank_card.svg", title: "Payment Methods"),
          _SettingItem(icon: "assets/icons/notification.svg", title: "Notifications"),
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

  const _SettingItem({
    required this.icon,
    required this.title,
    this.isFirst = false,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 62.h, // h 62
      padding: EdgeInsets.only(
        top: 16.h,
        bottom: 16.h,
        left: 16.w, // trái là 16
        right: 9.w, // phải là 9
      ),
      decoration: BoxDecoration(
        // Bo góc cho phần tử đầu và cuối
        borderRadius: BorderRadius.vertical(
          top: isFirst ? Radius.circular(16.r) : Radius.zero,
          bottom: isLast ? Radius.circular(16.r) : Radius.zero,
        ),
        // Viền được tô đậm để tạo hiệu ứng như 1 bảng
        border: Border(
          bottom: isLast
              ? BorderSide.none
              : BorderSide(color: AppColors.border.withOpacity(0.1)),
        ),
      ),
      child: Row(
        children: [
          // icon: 40x40
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
          SizedBox(width: 13.w), // cách bên phải là 13
          
          AppText.medium(title),
          
          const Spacer(),
          
          // nút mũi tên là 24x24
          const AppIcon("assets/icons/next.svg", color: AppColors.border),
        ],
      ),
    );
  }
}
