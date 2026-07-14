import 'package:coffee/core/constants/constants.dart';
import 'package:coffee/core/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'widgets/payment_widgets/coffee_pay_card.dart';
import 'widgets/payment_widgets/payment_method_list.dart';
import 'widgets/payment_widgets/add_card_button.dart';
import 'widgets/payment_widgets/payment_bottom_confirm.dart';

class PaymentMethodScreen extends StatelessWidget {
  const PaymentMethodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: AppSizes.screenPadding,
              child: Column(
                children: [
                  // AppBar cố định
                  SizedBox(height: 16.h),
                  const AppBarCoffee(title: "Payment Method"),
                  
                  // Nội dung cuộn
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 24.h),
                          
                          // Khung Coffee Pay màu mè (314x189)
                          const CoffeePayCard(),
                          
                          SizedBox(height: 20.h),
                          
                          // Tiêu đề Saved Method
                          AppText.medium("Saved Method", color: AppColors.border),
                          SizedBox(height: 9.h),
                          
                          // Danh sách các thẻ lựa chọn (314x64 mỗi thẻ)
                          const PaymentMethodList(),
                          
                          // Khung thêm card mới (314x64, viền dash)
                          const AddCardButton(),
                          
                          // Khoảng trống cho phần Bottom Confirm
                          SizedBox(height: 200.h),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            // Phần tổng thanh toán và nút Confirm ở dưới cùng
            const Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: PaymentBottomConfirm(totalPrice: 15.06),
            ),
          ],
        ),
      ),
    );
  }
}
