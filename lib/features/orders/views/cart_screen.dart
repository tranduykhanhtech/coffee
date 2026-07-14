import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constants.dart';
import '../../../core/widgets/app_bar.dart';
import 'widgets/address_section.dart';
import 'widgets/cart_item_card.dart';
import 'widgets/payment_summary.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Đã xóa phần AppBar mặc định của Scaffold vì bạn đã dùng AppBarCoffee bên trong body
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: AppSizes.screenPadding,
              child: Column(
                children: [
                  // Sử dụng AppBarCoffee ở đây như một Widget bình thường trong Column
                  const AppBarCoffee(title: "My Cart"),
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 24.h),
                          // Address Section Card
                          const AddressSection(),
                          SizedBox(height: 17.h),

                          // Cart Items List
                          const CartItemCard(
                            imageUrl: "assets/images/mocha.png", // Verify path
                            name: "Flat White",
                            subName: "Espresso · L",
                            price: 3.53,
                            quantity: 1,
                          ),
                          SizedBox(height: 17.h,),
                          const CartItemCard(
                            imageUrl: "assets/images/mocha.png",
                            name: "Caffe Mocha",
                            subName: "Deep Foam · M",
                            price: 3.53,
                            quantity: 1,
                          ),
                          SizedBox(height: 17.h,),
                          const CartItemCard(
                            imageUrl: "assets/images/mocha.png",
                            name: "Caffe Mocha",
                            subName: "Espresso · L",
                            price: 3.53,
                            quantity: 1,
                          ),
                          SizedBox(height: 17.h,),
                          const CartItemCard(
                            imageUrl: "assets/images/mocha.png",
                            name: "Caffe Mocha",
                            subName: "Espresso · L",
                            price: 3.53,
                            quantity: 1,
                          ),
                          
                          // Space for bottom summary
                          SizedBox(height: 200.h),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Bottom Payment Summary
            const Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: PaymentSummary(),
            ),
          ],
        ),
        // tách tới đây
      ),
    );
  }
}
