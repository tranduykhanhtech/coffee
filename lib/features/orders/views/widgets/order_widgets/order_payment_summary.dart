import 'package:coffee/core/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderPaymentSummary extends StatelessWidget {
  final double price; // Nhận giá từ màn hình cha
  const OrderPaymentSummary({super.key, required this.price});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText.medium("Payment Summary"),
          SizedBox(height: 16.h),
          _SummaryRow(label: "Price", value: "\$ $price"),
          SizedBox(height: 8.h),
          const _SummaryRow(
            label: "Delivery Fee",
            value: "\$ 1.0",
            originalValue: "\$ 2.0",
          ),
        ],
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final String? originalValue;

  const _SummaryRow({
    required this.label,
    required this.value,
    this.originalValue,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppText.small(label, color: AppColors.textMain),
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
              fontWeight: FontWeight.w600,
            ),
          ],
        ),
      ],
    );
  }
}
