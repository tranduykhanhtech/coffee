import 'package:coffee/core/constants/constants.dart';
import 'package:coffee/core/widgets/app_icon.dart';
import 'package:coffee/core/widgets/primary_button.dart';
import 'package:coffee/features/orders/controllers/order_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class OrderBottomAction extends GetView<OrderController> {
  const OrderBottomAction({super.key});

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
            color: Colors.black.withAlpha(12), // 0.05 * 255 ≈ 12
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
          // Khung phương thức thanh toán
          GestureDetector(
            onTap: () => controller.showPaymentMethodPicker(),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 8.h),
              color: Colors.transparent, // Tăng diện tích click
              child: Row(
                children: [
                  Obx(() => AppIcon(
                    controller.selectedPaymentMethod.value == 'CASH' 
                        ? "assets/icons/cash_wallet.svg" 
                        : "assets/icons/bank_card.svg", 
                    size: 20,
                  )),
                  SizedBox(width: 16.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Obx(() => AppText(
                        controller.selectedPaymentMethod.value == 'CASH' 
                            ? "Cash on Delivery" 
                            : "Credit Card (Stripe)",
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      )),
                      Obx(() => AppText.tiny(
                        "\$ ${controller.totalPayment.toStringAsFixed(1)}",
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      )),
                    ],
                  ),
                  const Spacer(),
                  const AppIcon("assets/icons/down.svg", size: 24),
                ],
              ),
            ),
          ),
          
          SizedBox(height: 8.h),
          
          // Nút Order tích hợp thanh toán
          Obx(() => PrimaryButton(
            buttonContext: "Order",
            isLoading: controller.isProcessingPayment.value,
            onPressed: () => controller.processPayment(),
          )),
        ],
      ),
    );
  }
}
