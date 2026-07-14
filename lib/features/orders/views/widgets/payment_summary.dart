import 'package:coffee/core/services/cart_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/widgets/primary_button.dart';

class PaymentSummary extends StatelessWidget {
  const PaymentSummary({super.key});

  @override
  Widget build(BuildContext context) {
    final cartService = Get.find<CartService>();

    return Obx(() => Container(
      padding: EdgeInsets.all(24.w),
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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _SummaryRow(label: "Price", value: "\$ ${cartService.subtotal.toStringAsFixed(2)}"),
          SizedBox(height: 8.h),
          _SummaryRow(
            label: "Delivery Fee",
            value: "\$ ${cartService.deliveryFee.toStringAsFixed(2)}",
            originalValue: cartService.cartItems.isEmpty ? null : "\$ 2.0",
          ),
          SizedBox(height: 16.h),
          Row(
            children: List.generate(
              150 ~/ 2,
              (index) => Expanded(
                child: Container(
                  color: index % 2 == 0 ? Colors.transparent : AppColors.border.withOpacity(0.3),
                  height: 1,
                ),
              ),
            ),
          ),
          SizedBox(height: 16.h),
          _SummaryRow(
            label: "Total Payment",
            value: "\$ ${cartService.totalPayment.toStringAsFixed(2)}",
            isTotal: true,
          ),
          SizedBox(height: 24.h),
          PrimaryButton(
            buttonContext: "Checkout",
            onPressed: () {},
          ),
        ],
      ),
    ));
  }
}

// class tạo các hàng giá cả
class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final String? originalValue;
  final bool isTotal;

  const _SummaryRow({
    required this.label,
    required this.value,
    this.originalValue,
    this.isTotal = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppText(
          label,
          fontSize: isTotal ? 16.sp : 14.sp,
          fontWeight: FontWeight.w400,
          color: isTotal ? AppColors.textMain : AppColors.border,
        ),
        Row(
          children: [
            if (originalValue != null) ...[
              Text(
                originalValue!,
                style: TextStyle(
                  decoration: TextDecoration.lineThrough,
                  color: AppColors.border,
                  fontSize: 14.sp,
                ),
              ),
              SizedBox(width: 8.w),
            ],
            AppText(
              value,
              fontSize: isTotal ? 16.sp : 14.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.textMain,
            ),
          ],
        ),
      ],
    );
  }
}
