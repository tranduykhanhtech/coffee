import 'package:coffee/core/constants/constants.dart';
import 'package:coffee/core/repository/user_repository.dart';
import 'package:coffee/core/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  final UserRepository repository;
  ProfileController({required this.repository});

  var isLoading = false.obs;
  var address = "".obs;
  var displayName = "".obs;
  var avatarUrl = "".obs;

  final addressController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    fetchUserData();
  }

  /// Lấy thông tin user hiện tại
  Future<void> fetchUserData() async {
    try {
      final user = repository.currentUser;
      if (user == null) {
        clearData();
        return;
      }

      isLoading.value = true;
      final data = await repository.getUserProfile(user.id);
      
      if (data != null) {
        address.value = data['bio'] ?? ""; 
        displayName.value = data['display_name'] ?? "";
        avatarUrl.value = data['avatar_url'] ?? "";
        addressController.text = address.value;
      }
    } catch (e) {
      // Get.snackbar("Lỗi", "Không thể tải thông tin: ${e.toString()}");
      print("--- ERROR fetching profile: $e");
    } finally {
      isLoading.value = false;
    }
  }

  /// Xóa sạch dữ liệu khi logout
  void clearData() {
    address.value = "";
    displayName.value = "";
    avatarUrl.value = "";
    addressController.clear();
  }

  /// Cập nhật địa chỉ (dạng text - Giai đoạn 1)
  Future<void> updateAddress() async {
    try {
      final user = repository.currentUser;
      if (user == null) return;

      isLoading.value = true;
      
      // Ở giai đoạn 1, ô yêu cầu cập nhật địa chỉ dạng Text
      // Tui sẽ lưu vào cột 'bio' hoặc một cột địa chỉ nếu ô đã thêm vào bảng users
      // Dựa trên SQL ô gửi, tui sẽ dùng 'bio' để lưu địa chỉ tạm thời nếu chưa có cột address
      await repository.updateProfile(user.id, {
        'bio': addressController.text.trim(),
      });

      address.value = addressController.text.trim();
      Get.back(); // Đóng bottom sheet hoặc dialog
      Get.snackbar("Thành công", "Đã cập nhật địa chỉ giao hàng");
    } catch (e) {
      Get.snackbar("Lỗi", "Không thể cập nhật: ${e.toString()}");
    } finally {
      isLoading.value = false;
    }
  }

  /// Hiển thị Bottom Sheet để sửa địa chỉ
  void showEditAddressSheet() {
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
            AppText.medium("Edit Delivery Address"),
            SizedBox(height: 16.h),
            TextField(
              controller: addressController,
              decoration: InputDecoration(
                hintText: "Enter your address",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                contentPadding: EdgeInsets.all(16.w),
              ),
              maxLines: 2,
            ),
            SizedBox(height: 24.h),
            Obx(() => PrimaryButton(
              buttonContext: "Save Address",
              isLoading: isLoading.value,
              onPressed: () => updateAddress(),
            )),
            SizedBox(height: 16.h),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }

  @override
  void onClose() {
    addressController.dispose();
    super.onClose();
  }
}
