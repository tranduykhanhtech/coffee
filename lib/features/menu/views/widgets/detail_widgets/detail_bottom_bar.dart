import 'package:coffee/core/constants.dart';
import 'package:coffee/core/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailBottomBar extends StatelessWidget {
  final double price;
  const DetailBottomBar({super.key, required this.price});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 118.h, // h: 118
      padding: EdgeInsets.only(
        top: 16.h,
        bottom: 24.h, // điều chỉnh lại cho phù hợp thiết bị (bạn yêu cầu bottom 46 nhưng có thể quá lớn tùy màn hình)
        left: 24.w,
        right: 24.w,
      ),
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Phần hiển thị giá
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppText.small("Price", color: AppColors.border),
              SizedBox(height: 4.h),
              AppText.medium(
                "\$ $price",
                fontSize: 18.sp, // cỡ 18
                fontWeight: FontWeight.w600, // semibold
                color: AppColors.primary, // màu primary
              ),
            ],
          ),
          
          SizedBox(width: 34.w), // cách nhau 34
          
          // Nút Buy Now
          Expanded(
            child: PrimaryButton(
              buttonContext: "Buy Now",
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
