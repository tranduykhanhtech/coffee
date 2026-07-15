import 'package:coffee/core/services/cart_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/constants/constants.dart';
import '../../../core/widgets/app_bar.dart';
import 'widgets/address_section.dart';
import 'widgets/cart_item_card.dart';
import 'widgets/payment_summary.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartService = Get.find<CartService>();

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: AppSizes.screenPadding,
              child: Column(
                children: [
                  const AppBarCoffee(
                    title: "My Cart",
                    showBackButton: true, // Hiện nút back ở màn Cart để quay lại Home
                  ),
                  Expanded(
                    child: Obx(() {
                      if (cartService.cartItems.isEmpty) {
                        return Center(
                          child: AppText.medium("Giỏ hàng của bạn đang trống"),
                        );
                      }
                      return SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 24.h),
                            const AddressSection(),
                            SizedBox(height: 17.h),
                            
                            // Render real cart items
                            ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: cartService.cartItems.length,
                              separatorBuilder: (context, index) => SizedBox(height: 17.h),
                              itemBuilder: (context, index) {
                                final item = cartService.cartItems[index];
                                return CartItemCard(
                                  productSizeId: item.productSizeId,
                                  imageUrl: item.fullImageUrl,
                                  name: item.productName ?? "Unknown",
                                  subName: item.productSubname ?? "",
                                  price: item.price ?? 0.0,
                                  quantity: item.quantity,
                                );
                              },
                            ),

                            SizedBox(height: 200.h),
                          ],
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
            const Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: PaymentSummary(),
            ),
          ],
        ),
      ),
    );
  }
}
