import 'package:coffee/core/constants.dart';
import 'package:coffee/core/widgets/app_bar.dart';
import 'package:coffee/core/widgets/app_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'widgets/profile_widgets/profile_header.dart';
import 'widgets/profile_widgets/profile_stats.dart';
import 'widgets/profile_widgets/profile_member_card.dart';
import 'widgets/profile_widgets/profile_settings_list.dart';
import 'widgets/profile_widgets/logout_button.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
              
              // Nội dung có thể cuộn
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      SizedBox(height: 24.h),
                      
                      // Cụm thông tin cá nhân (Avatar, Tên, Email)
                      const ProfileHeader(
                        name: "Tran Duy Khanh",
                        email: "khanh.tran@coffee.com",
                        avatarUrl: "assets/images/avatar.png",
                      ),
                      
                      SizedBox(height: 15.h), // cách cụm ttcn là 15
                      
                      // Khung thống kê (Order, Points, Reviews)
                      const ProfileStats(),
                      
                      SizedBox(height: 24.h),
                      
                      // Khung member (Coffee Member · Gold)
                      const ProfileMemberCard(),
                      
                      SizedBox(height: 24.h),
                      
                      // Khung chức năng (My Orders, Address, etc.)
                      const ProfileSettingsList(),
                      
                      SizedBox(height: 20.h), // cách danh sách chức năng là 20
                      
                      // Nút Log Out
                      const LogoutButton(),
                      
                      SizedBox(height: 40.h), // Khoảng đệm dưới cùng
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
