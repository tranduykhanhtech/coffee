import 'package:get/get.dart'; // Thêm import GetX
import 'package:coffee/features/menu/models/product_model.dart';
import 'package:coffee/features/menu/models/product_size_model.dart';
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
    // Lấy dữ liệu được truyền từ ItemDetailScreen
    final Map<String, dynamic> args = Get.arguments ?? {};
    final ProductModel? product = args["product"];
    final ProductSizeModel? selectedSize = args["selectedSize"];
    final double totalPrice = args["totalPrice"] ?? 0.0;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: AppSizes.screenPadding,
              child: Column(
                children: [
                  // Tiêu đề trang Order
                  const AppBarCoffee(title: "Order"),
                  
                  // Nội dung có thể cuộn
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 24.h),
                          
                          // Thanh chuyển địa điểm giao nhận (h: 43)
                          const DeliveryToggle(),
                          
                          SizedBox(height: 24.h),
                          
                          // Khung địa chỉ (h: 121)
                          const OrderAddressSection(),
                          
                          SizedBox(height: 16.h),
                          Divider(color: AppColors.border.withOpacity(0.2)),
                          SizedBox(height: 16.h),
                          
                          // Card sản phẩm (Đã cập nhật dữ liệu động)
                          OrderItemCard(
                            name: product?.productName ?? "No name",
                            subName: selectedSize?.sizeType ?? "",
                            imageUrl: product?.productImageUrl ?? "assets/images/mocha.png",
                          ),
                          
                          SizedBox(height: 16.h),
                          // Thanh màu ngăn cách
                          Container(
                            height: 4.h,
                            width: double.infinity,
                            color: const Color(0xFFF9F2ED),
                          ),
                          SizedBox(height: 16.h),
                          
                          // Card giảm giá (h: 56)
                          const DiscountCard(),
                          
                          SizedBox(height: 24.h),
                          
                          // Khung tổng giá (Đã cập nhật giá động)
                          OrderPaymentSummary(price: totalPrice),
                          
                          // Khoảng trống cho phần Bottom Action ở dưới
                          SizedBox(height: 180.h),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            // Khung order ở dưới cùng (phương thức thanh toán + nút Order)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: OrderBottomAction(totalPrice: totalPrice + 1.0), // Tổng tiền + 1.0 phí ship
            ),
          ],
        ),
      ),
    );
  }
}
