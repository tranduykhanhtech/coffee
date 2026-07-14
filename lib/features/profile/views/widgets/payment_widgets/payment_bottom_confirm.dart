import 'package:coffee/core/constants/constants.dart';
import 'package:coffee/core/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PaymentBottomConfirm extends StatelessWidget {
  final double totalPrice;
  const PaymentBottomConfirm({super.key, required this.totalPrice});

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
          // Total Payment
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText.small("Total Payment", color: AppColors.border),
              AppText.medium(
                "\$ $totalPrice",
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ],
          ),
          SizedBox(height: 5.h), // cách nút ở dưới là 5
          
          // Nút Confirm Payment
          PrimaryButton(
            buttonContext: "Confirm Payment",
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
