import 'package:coffee/core/routes/app_pages.dart';
import 'package:coffee/core/services/auth_service.dart';
import 'package:coffee/core/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:coffee/core/constants/constants.dart';
import 'package:coffee/core/widgets/app_bar.dart';
import 'package:coffee/core/widgets/app_icon.dart';
import 'package:coffee/features/profile/controllers/profile_controller.dart';
import 'widgets/profile_widgets/profile_header.dart';
import 'widgets/profile_widgets/profile_stats.dart';
import 'widgets/profile_widgets/profile_member_card.dart';
import 'widgets/profile_widgets/profile_settings_list.dart';
import 'widgets/profile_widgets/logout_button.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Get.find<AuthService>();
    final controller = Get.find<ProfileController>();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: AppSizes.screenPadding,
          child: Column(
            children: [
              // Thanh tiêu đề Profile
              const AppBarCoffee(
                title: "Profile",
                icon: AppIcon("assets/icons/edit_profile.svg", size: 25),
              ),
              
              // Sử dụng Obx để theo dõi trạng thái đăng nhập
              Expanded(
                child: Obx(() {
                  // Sau khi fix isLoggedIn thành reactive trong AuthService, 
                  // Obx này sẽ tự động rebuild khi trạng thái login thay đổi mà không gây crash.

                  // Nếu chưa đăng nhập, hiển thị màn hình yêu cầu Login
                  if (!authService.isLoggedIn) {
                    return _buildGuestPlaceholder();
                  }

                  // Nếu đã đăng nhập, hiển thị giao diện Profile bình thường
                  return SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        SizedBox(height: 24.h),
                        
                        // Cụm thông tin cá nhân dùng dữ liệu thật
                        ProfileHeader(
                          name: controller.displayName.value.isEmpty ? "Coffee Lover" : controller.displayName.value,
                          email: controller.repository.currentUser?.email ?? "No email",
                          avatarUrl: controller.avatarUrl.value,
                        ),
                        
                        SizedBox(height: 15.h),
                        
                        const ProfileStats(),
                        
                        SizedBox(height: 24.h),
                        
                        const ProfileMemberCard(),
                        
                        SizedBox(height: 24.h),
                        
                        const ProfileSettingsList(),
                        
                        SizedBox(height: 20.h),
                        
                        const LogoutButton(),
                        
                        SizedBox(height: 40.h),
                      ],
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

  // Giao diện dành cho khách chưa đăng nhập
  Widget _buildGuestPlaceholder() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(24.w),
            decoration: BoxDecoration(
              color: AppColors.primaryLight.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.person_outline,
              size: 80.sp,
              color: AppColors.primary,
            ),
          ),
          SizedBox(height: 24.h),
          AppText.medium(
            "Please Login to View Profile",
            fontSize: 18.sp,
          ),
          SizedBox(height: 8.h),
          AppText.small(
            "Login to manage your orders and profile information",
            color: AppColors.border,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 32.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.w),
            child: PrimaryButton(
              buttonContext: "Login Now",
              onPressed: () => Get.toNamed(Routes.LOGIN),
            ),
          ),
        ],
      ),
    );
  }
}
