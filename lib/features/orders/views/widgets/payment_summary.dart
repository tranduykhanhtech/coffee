import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants.dart';
import '../../../../core/widgets/primary_button.dart';

class PaymentSummary extends StatelessWidget {
  const PaymentSummary({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.r),
          topRight: Radius.circular(24.r),
        ),
        boxShadow: [
          // Hiệu ứng đổ bóng nhẹ để tách biệt phần tổng tiền với danh sách cuộn
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
          // Hiển thị giá tạm tính
          _SummaryRow(label: "Price", value: "\$ 14.06"),
          SizedBox(height: 8.h),
          // Hiển thị phí giao hàng (có giá cũ bị gạch ngang)
          _SummaryRow(
            label: "Delivery Fee",
            value: "\$ 1.0",
            originalValue: "\$ 2.0",
          ),
          SizedBox(height: 16.h),
          // Đường kẻ đứt (Dotted Line) theo thiết kế Figma
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
          // Tổng số tiền cuối cùng phải thanh toán
          _SummaryRow(
            label: "Total Payment",
            value: "\$ 15.06",
            isTotal: true,
          ),
          SizedBox(height: 24.h),
          // Nút bấm tiến hành thanh toán
          PrimaryButton(
            buttonContext: "Checkout",
            onPressed: () {},
          ),
        ],
      ),
    );
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
