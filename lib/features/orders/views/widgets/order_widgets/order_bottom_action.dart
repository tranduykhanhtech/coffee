import 'package:coffee/core/constants/constants.dart';
import 'package:coffee/core/widgets/app_icon.dart';
import 'package:coffee/core/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderBottomAction extends StatelessWidget {
  final double totalPrice; // Thêm biến nhận tổng tiền
  const OrderBottomAction({super.key, required this.totalPrice});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.r),
          topRight: Radius.circular(24.r),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      padding: EdgeInsets.only(
        top: 16.h,
        bottom: 46.h,
        left: 24.w,
        right: 24.w,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Khung phương thức thanh toán (h: 39)
          SizedBox(
            //height: 39.h,
            child: Row(
              children: [
                const AppIcon("assets/icons/cash_wallet.svg", size: 20), // Icon ví 20x20
                SizedBox(width: 16.w), // cách bên phải 16
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppText(
                      "Cash/Wallet",
                      fontSize: 14.sp, // small
                      fontWeight: FontWeight.w600, // semiBold
                    ),
                    AppText.tiny(
                      "\$ $totalPrice", // Hiển thị tổng tiền thực tế
                      fontWeight: FontWeight.w600, // semiBold
                      color: AppColors.primary,
                    ),
                  ],
                ),
                const Spacer(),
                const AppIcon("assets/icons/down.svg", size: 24), // 24x24
              ],
            ),
          ),
          
          SizedBox(height: 8.h), // cách khung chọn phương thức là 8
          
          // Nút Order
          PrimaryButton(
            buttonContext: "Order",
            onPressed: () {
              // Xử lý sự kiện khi nhấn nút đặt hàng
            },
          ),
        ],
      ),
    );
  }
}
