import 'package:coffee/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileStats extends StatelessWidget {
  const ProfileStats({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75.h, // h là 75
      padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 7.w), // pad dọc: 14, ngang: 7
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r), // bo góc 16
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          const _StatItem(value: "48", label: "Order"),
          _buildDivider(),
          const _StatItem(value: "1.2K", label: "Points"),
          _buildDivider(),
          const _StatItem(value: "16", label: "Reviews"),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      width: 1,
      height: 20.h,
      color: AppColors.border.withOpacity(0.2),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String value;
  final String label;

  const _StatItem({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Giá trị: cỡ medium, regular
          AppText.medium(
            value,
            fontWeight: FontWeight.normal,
          ),
          SizedBox(height: 4.h), // cách chữ dưới là 4
          // Nhãn: cỡ tiny, màu border
          AppText.tiny(
            label,
            color: AppColors.border,
            fontWeight: FontWeight.normal,
          ),
        ],
      ),
    );
  }
}
