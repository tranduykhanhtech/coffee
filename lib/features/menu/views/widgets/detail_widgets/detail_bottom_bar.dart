import 'package:coffee/core/utils.dart'; // Thêm import utils để format giá
import 'package:coffee/core/constants/constants.dart';
import 'package:coffee/core/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailBottomBar extends StatelessWidget {
  final double price;
  final VoidCallback? onBuyNow; // Thêm callback xử lý khi nhấn nút Buy Now
  final VoidCallback? onAddToCart; // Thêm callback cho giỏ hàng

  const DetailBottomBar({
    super.key,
    required this.price,
    this.onBuyNow,
    this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120.h,
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.r),
          topRight: Radius.circular(16.r),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        children: [
          // Phần hiển thị giá
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppText.small("Price", color: AppColors.border),
              SizedBox(height: 4.h),
              AppText.medium(
                "\$ ${AppUtils.formatPrice(price)}",
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
            ],
          ),
          
          SizedBox(width: 24.w),
          
          // Nút Add to Cart (Icon)
          GestureDetector(
            onTap: onAddToCart,
            child: Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: const Icon(Icons.add_shopping_cart, color: AppColors.primary),
            ),
          ),

          SizedBox(width: 12.w),
          
          // Nút Buy Now
          Expanded(
            child: PrimaryButton(
              buttonContext: "Buy Now",
              onPressed: onBuyNow,
            ),
          ),
        ],
      ),
    );
  }
}
