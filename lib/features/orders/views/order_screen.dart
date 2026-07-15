import 'package:coffee/features/orders/controllers/order_controller.dart';
import 'package:get/get.dart';
import 'package:coffee/core/constants/constants.dart';
import 'package:coffee/core/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'widgets/order_widgets/delivery_toggle.dart';
import 'widgets/order_widgets/order_address_section.dart';
import 'widgets/order_widgets/order_item_card.dart';
import 'widgets/order_widgets/discount_card.dart';
import 'widgets/order_widgets/order_payment_summary.dart';
import 'widgets/order_widgets/order_bottom_action.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Khởi tạo OrderController
    // Tag dùng để phân biệt các instance nếu cần, nhưng ở đây dùng Get.put là đủ
    final controller = Get.put(OrderController());

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: AppSizes.screenPadding,
              child: Column(
                children: [
                  const AppBarCoffee(
                    title: "Order",
                    showBackButton: true, // Màn thanh toán cần nút back
                  ),
                  
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 24.h),
                          const DeliveryToggle(),
                          SizedBox(height: 24.h),
                          const OrderAddressSection(),
                          
                          SizedBox(height: 16.h),
                          Divider(color: AppColors.border.withAlpha(51)),
                          SizedBox(height: 16.h),
                          
                          // Danh sách sản phẩm trong đơn hàng
                          Obx(() => ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: controller.orderItems.length,
                            separatorBuilder: (context, index) => SizedBox(height: 16.h),
                            itemBuilder: (context, index) {
                              final item = controller.orderItems[index];
                              return OrderItemCard(
                                index: index,
                                name: item.productName ?? "No name",
                                subName: item.productSubname ?? "",
                                imageUrl: item.fullImageUrl,
                              );
                            },
                          )),
                          
                          SizedBox(height: 16.h),
                          Container(
                            height: 4.h,
                            width: double.infinity,
                            color: const Color(0xFFF9F2ED),
                          ),
                          SizedBox(height: 16.h),
                          
                          const DiscountCard(),
                          SizedBox(height: 24.h),
                          const OrderPaymentSummary(),
                          SizedBox(height: 180.h),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            const Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: OrderBottomAction(),
            ),
          ],
        ),
      ),
    );
  }
}
