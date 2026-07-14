import 'package:coffee/core/constants/constants.dart';
import 'package:coffee/core/widgets/app_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CoffeePayCard extends StatelessWidget {
  const CoffeePayCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 314.w,
      height: 189.h,
      padding: EdgeInsets.all(10.w), // padding 4 mặt là 15
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(16.r), // bo góc 16
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Hàng trên cùng: Icon và chữ Coffee Pay
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const AppIcon("assets/icons/bank_card.svg", size: 30), // icon 30x30
              AppText(
                "Coffee Pay",
                fontSize: 14.sp, // small
                fontWeight: FontWeight.w600, // semibold
                color: Colors.white,
              ),
            ],
          ),
          SizedBox(height: 31.h), // cách bên dưới là 31
          
          // Wallet Balance
          AppText.medium(
            "Wallet Balance",
            color: Colors.white.withOpacity(0.7), // opacity 70%
          ),
          
          // Số tiền balance
          AppText.big(
            "\$ 24.50",
            color: Colors.white,
          ),
          
          const Spacer(),
          
          // Tên chủ ví
          AppText(
            "Tran Duy Khanh",
            fontSize: 14.sp, // small
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
