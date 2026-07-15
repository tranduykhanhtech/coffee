import 'package:coffee/core/repository/payment_repository.dart';
import 'package:coffee/core/widgets/app_icon.dart';
import 'package:coffee/features/orders/controllers/order_history_controller.dart';
import 'package:coffee/features/profile/controllers/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/constants/constants.dart';
import '../../../core/routes/app_pages.dart';
import '../../../core/services/cart_service.dart';
import '../../../core/services/favorite_service.dart';
import '../../../core/services/payment_service.dart';
import '../models/cart_item_model.dart';
import '../../menu/models/product_model.dart';
import '../../menu/models/product_size_model.dart';
import '../repository/order_repository.dart';

class OrderController extends GetxController {
  final _paymentService = Get.find<PaymentService>();
  final _orderRepository = Get.find<OrderRepository>();
  final _paymentRepository = Get.find<PaymentRepository>();
  final _profileController = Get.find<ProfileController>();
  
  // Trạng thái giao hàng: true = Deliver, false = Pick Up
  var isDeliver = true.obs;
  
  // Danh sách các món trong đơn hàng hiện tại
  var orderItems = <CartItemModel>[].obs;

  var isProcessingPayment = false.obs;

  // Lựa chọn phương thức thanh toán: 'CASH' hoặc 'BANK_TRANSFER' (Stripe)
  var selectedPaymentMethod = 'CASH'.obs;

  @override
  void onInit() {
    super.onInit();
    final Map<String, dynamic> args = Get.arguments ?? {};
    
    if (args.containsKey("items")) {
      final List<CartItemModel> items = args["items"];
      orderItems.assignAll(items);
    } else if (args.containsKey("product")) {
      final ProductModel product = args["product"];
      final ProductSizeModel? selectedSize = args["selectedSize"];
      final double price = args["totalPrice"] ?? 0.0;
      
      orderItems.add(CartItemModel(
        productId: product.id,
        productSizeId: selectedSize?.id ?? "",
        quantity: 1,
        productName: product.productName,
        productSubname: selectedSize?.sizeType ?? product.productSubname,
        imageUrl: product.productImageUrl,
        price: price,
      ));
    }
  }

  void setDeliveryMode(bool deliver) {
    isDeliver.value = deliver;
  }

  void updatePaymentMethod(String method) {
    selectedPaymentMethod.value = method;
  }

  void incrementQuantity(int index) {
    final item = orderItems[index];
    orderItems[index] = item.copyWith(quantity: item.quantity + 1);
  }

  void decrementQuantity(int index) {
    final item = orderItems[index];
    if (item.quantity > 1) {
      orderItems[index] = item.copyWith(quantity: item.quantity - 1);
    }
  }

  double get subtotal => orderItems.fold(0, (sum, item) => sum + ((item.price ?? 0) * item.quantity));
  double get deliveryFee => isDeliver.value ? 1.0 : 0.0;
  double get totalPayment => subtotal + deliveryFee;

  /// Hiển thị BottomSheet chọn phương thức thanh toán
  void showPaymentMethodPicker() {
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(24.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText.medium("Select Payment Method"),
            SizedBox(height: 16.h),
            _buildMethodOption(
              "Cash on Delivery",
              'CASH',
              "assets/icons/cash_wallet.svg",
            ),
            SizedBox(height: 12.h),
            _buildMethodOption(
              "Credit Card (Stripe)",
              'BANK_TRANSFER',
              "assets/icons/bank_card.svg",
            ),
            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }

  Widget _buildMethodOption(String title, String method, String icon) {
    return Obx(() => GestureDetector(
      onTap: () {
        updatePaymentMethod(method);
        Get.back();
      },
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: selectedPaymentMethod.value == method 
              ? AppColors.primary.withOpacity(0.1) 
              : Colors.grey.withOpacity(0.05),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: selectedPaymentMethod.value == method ? AppColors.primary : Colors.transparent,
          ),
        ),
        child: Row(
          children: [
            AppIcon(icon, size: 24, color: selectedPaymentMethod.value == method ? AppColors.primary : AppColors.border),
            SizedBox(width: 16.w),
            AppText.medium(title, color: selectedPaymentMethod.value == method ? AppColors.primary : AppColors.textMain),
            const Spacer(),
            if (selectedPaymentMethod.value == method)
              const Icon(Icons.check_circle, color: AppColors.primary),
          ],
        ),
      ),
    ));
  }

  /// Luồng xử lý thanh toán
  Future<void> processPayment() async {
    try {
      if (orderItems.isEmpty) return;
      isProcessingPayment.value = true;

      String? paymentId;

      if (selectedPaymentMethod.value == 'BANK_TRANSFER') {
        // Luồng thanh toán Stripe
        await _paymentService.initPaymentSheet(totalPayment, "usd");
        await _paymentService.presentPaymentSheet();
        
        // Tạo bản ghi thanh toán thành công
        paymentId = await _paymentRepository.createPaymentRecord(
          userId: _orderRepository.currentUser!.id,
          method: 'BANK_TRANSFER',
          status: 'SUCCESS',
        );
      } else {
        // Luồng Tiền mặt: Tạo bản ghi thanh toán PENDING
        paymentId = await _paymentRepository.createPaymentRecord(
          userId: _orderRepository.currentUser!.id,
          method: 'CASH',
          status: 'PENDING',
        );
      }

      // Lưu đơn hàng vào Database
      await createOrder(paymentId: paymentId);

      // Đồng bộ Yêu thích
      await Get.find<FavoriteService>().syncFavoritesToSupabase();

      // Dọn dẹp giỏ hàng
      await Get.find<CartService>().clearCart();

      // Cập nhật Lịch sử
      await Get.find<OrderHistoryController>().fetchOrderHistory();

      Get.snackbar("Thành công", "Đơn hàng của bạn đã được ghi nhận!");
      Get.offAllNamed(Routes.DASHBOARD, arguments: 3); 
    } catch (e) {
      Get.snackbar("Thất bại", e.toString());
    } finally {
      isProcessingPayment.value = false;
    }
  }

  Future<void> createOrder({String? paymentId}) async {
    final user = _orderRepository.currentUser;
    if (user == null) throw Exception("User not logged in");

    final String deliveryAddress = isDeliver.value 
        ? "280 An Nhon, Ho Chi Minh" 
        : _profileController.address.value;

    final List<Map<String, dynamic>> items = orderItems.map((item) {
      if (item.productId == null) {
        throw Exception("Lỗi: Không tìm thấy ID sản phẩm cho món ${item.productName}");
      }
      return {
        'product_id': item.productId,
        'quantity': item.quantity,
      };
    }).toList();

    await _orderRepository.placeOrder(
      userId: user.id,
      totalAmount: totalPayment,
      deliveryFee: deliveryFee,
      address: deliveryAddress,
      items: items,
      paymentId: paymentId,
    );
  }
}
