import 'package:coffee/core/constants/constants.dart';
import 'package:coffee/core/supabase_client.dart';
import 'package:coffee/core/widgets/app_bar.dart';
import 'package:coffee/core/widgets/custom_image.dart';
import 'package:coffee/features/orders/controllers/order_history_controller.dart';
import 'package:coffee/features/orders/models/order_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<OrderHistoryController>();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: AppSizes.screenPadding,
          child: Column(
            children: [
              const AppBarCoffee(title: "Order History"),
              Expanded(
                child: Obx(() {
                  if (controller.isLoading.value && controller.orderHistory.isEmpty) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (controller.orderHistory.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.history, size: 64.sp, color: AppColors.border),
                          SizedBox(height: 16.h),
                          AppText.medium("No orders found", color: AppColors.border),
                        ],
                      ),
                    );
                  }

                  return RefreshIndicator(
                    onRefresh: controller.refreshHistory,
                    child: ListView.separated(
                      padding: EdgeInsets.symmetric(vertical: 24.h),
                      itemCount: controller.orderHistory.length,
                      separatorBuilder: (context, index) => SizedBox(height: 16.h),
                      itemBuilder: (context, index) {
                        final order = controller.orderHistory[index];
                        return _OrderHistoryCard(order: order);
                      },
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _OrderHistoryCard extends StatelessWidget {
  final OrderModel order;
  const _OrderHistoryCard({required this.order});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(5),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: Order Code & Status
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: AppText.medium(
                  order.orderCode ?? "Order",
                  fontSize: 16.sp,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(width: 8.w),
              _StatusBadge(status: order.orderStatus),
            ],
          ),
          SizedBox(height: 4.h),
          AppText.small(
            DateFormat('dd MMM yyyy, HH:mm').format(order.createdAt),
            color: AppColors.border,
          ),
          
          SizedBox(height: 12.h),
          const Divider(),
          SizedBox(height: 12.h),

          // Danh sách các món trong đơn hàng
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: order.details.length,
            separatorBuilder: (context, index) => SizedBox(height: 12.h),
            itemBuilder: (context, index) {
              final detail = order.details[index];
              final imageUrl = detail.productImage != null 
                  ? SupabaseConfig.getPublicUrl(AppConstants.bucketProducts, detail.productImage!)
                  : "";

              return Row(
                children: [
                  CustomImage(
                    width: 45.w,
                    height: 45.h,
                    imageUrl: imageUrl,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText.medium(
                          detail.productName ?? "Unknown Product",
                          fontSize: 14.sp,
                        ),
                        AppText.tiny(
                          "Quantity: x${detail.quantity}",
                          color: AppColors.border,
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),

          SizedBox(height: 16.h),
          const Divider(),
          SizedBox(height: 8.h),

          // Footer: Total
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Builder(
                builder: (context) {
                  final totalQuantity = order.details.fold<int>(0, (sum, item) => sum + item.quantity);
                  return AppText.small(
                    "Total $totalQuantity item(s)",
                    color: AppColors.textMain,
                  );
                }
              ),
              Row(
                children: [
                  AppText.small("Total Payment: ", color: AppColors.border),
                  AppText.medium(
                    "\$ ${order.totalAmount.toStringAsFixed(1)}",
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final String status;
  const _StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    Color color;
    switch (status.toUpperCase()) {
      case 'PENDING':
        color = Colors.orange;
        break;
      case 'PREPARING':
        color = Colors.blue;
        break;
      case 'SHIPPING':
        color = Colors.blue;
        break;
      case 'COMPLETED':
        color = Colors.green;
        break;
      case 'CANCELLED':
        color = Colors.red;
        break;
      default:
        color = AppColors.border;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: color.withAlpha(25),
        borderRadius: BorderRadius.circular(6.r),
        border: Border.all(color: color.withAlpha(50)),
      ),
      child: AppText.tiny(
        status,
        color: color,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
