import 'package:coffee/core/constants/constants.dart';
import 'package:coffee/features/orders/controllers/order_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class OrderPaymentSummary extends GetView<OrderController> {
  const OrderPaymentSummary({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final double subtotal = controller.subtotal;
      final double deliveryFee = controller.deliveryFee;
      final double totalPayment = controller.totalPayment;

      return SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText.medium("Payment Summary"),
            SizedBox(height: 16.h),
            _SummaryRow(label: "Price", value: "\$ ${subtotal.toStringAsFixed(1)}"),
            SizedBox(height: 8.h),
            _SummaryRow(
              label: "Delivery Fee",
              value: "\$ ${deliveryFee.toStringAsFixed(1)}",
              // Chỉ hiện giá cũ nếu là Deliver và có phí
              originalValue: deliveryFee > 0 ? "\$ 2.0" : null,
            ),
            SizedBox(height: 8.h),
            const Divider(),
            SizedBox(height: 8.h),
            _SummaryRow(
              label: "Total Payment", 
              value: "\$ ${totalPayment.toStringAsFixed(1)}",
              isTotal: true,
            ),
          ],
        ),
      );
    });
  }
}

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
        AppText.small(
          label, 
          color: AppColors.textMain,
          fontWeight: isTotal ? FontWeight.w600 : FontWeight.normal,
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
            AppText.medium(
              value,
              fontSize: 14.sp,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.w600,
              color: isTotal ? AppColors.primary : AppColors.textMain,
            ),
          ],
        ),
      ],
    );
  }
}
