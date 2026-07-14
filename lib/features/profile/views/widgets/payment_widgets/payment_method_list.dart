import 'package:coffee/core/constants/constants.dart';
import 'package:coffee/core/widgets/app_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PaymentMethodList extends StatefulWidget {
  const PaymentMethodList({super.key});

  @override
  State<PaymentMethodList> createState() => _PaymentMethodListState();
}

class _PaymentMethodListState extends State<PaymentMethodList> {
  int selectedIndex = 0;

  final List<Map<String, String>> methods = [
    {"label": "Cash", "name": "Cash / Wallet", "info": "Balance \$ 24.50"},
    {"label": "VISA", "name": "Visa", "info": "**** **** **** 4129"},
    {"label": "MC", "name": "Mastercard", "info": "**** **** **** 8821"},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(methods.length, (index) {
        final isSelected = selectedIndex == index;
        final item = methods[index];
        
        return GestureDetector(
          onTap: () => setState(() => selectedIndex = index),
          child: Container(
            width: 314.w,
            height: 64.h,
            margin: EdgeInsets.only(bottom: 12.h),
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(
                color: isSelected ? AppColors.primary : Colors.transparent,
                width: 1,
              ),
            ),
            child: Row(
              children: [
                // Icon có chữ (63x32)
                Container(
                  width: 63.w,
                  height: 32.h,
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Center(
                    child: AppText.tiny(
                      item["label"]!,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(width: 12.w), // cách mục bên phải là 3 (theo hình ảnh khoảng cách lớn hơn 3)
                
                // Thông tin text
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppText(
                        item["name"]!,
                        fontSize: 14.sp, // small
                        fontWeight: FontWeight.w600,
                      ),
                      AppText.tiny(
                        item["info"]!,
                        color: AppColors.border,
                      ),
                    ],
                  ),
                ),
                
                // Icon tick (24x24)
                if (isSelected)
                  const AppIcon("assets/icons/tick.svg", size: 24),
              ],
            ),
          ),
        );
      }),
    );
  }
}
