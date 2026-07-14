import 'package:coffee/core/routes/app_pages.dart';
import 'package:coffee/features/profile/views/profile_screen.dart'; // Thêm import này
import 'package:get/get.dart';
import 'package:coffee/features/menu/views/favorite_screen.dart';
import 'package:coffee/features/menu/views/home_screen.dart';
import 'package:coffee/features/notifications/views/notification_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constants/constants.dart'; // Import AppColors
import '../../../core/widgets/app_icon.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _selectedIndex = 0;

  final List<Widget> _page = [
    const HomeScreen(),
    const FavoriteScreen(),
    const NotificationScreen(),
    const ProfileScreen(), // Đã có import nên không còn lỗi
  ];

  void _changeScreen(int index) {
    if (index == 2) {
      Get.toNamed(Routes.CART);
      return;
    }
    
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Logic index cho IndexedStack: index 2 của BottomBar là Cart (không nằm trong stack)
    int stackIndex = _selectedIndex;
    if (_selectedIndex > 2) stackIndex = _selectedIndex - 1;

    return Scaffold(
      body: IndexedStack(
        index: stackIndex, 
        children: _page
      ),
      bottomNavigationBar: Container(
        height: 99.h,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          currentIndex: _selectedIndex,
          onTap: _changeScreen,
          items: [
            BottomNavigationBarItem(
              icon: AppIcon("assets/icons/home.svg"),
              activeIcon: AppIcon("assets/icons/home_active.svg"),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: AppIcon("assets/icons/favorite.svg"),
              activeIcon: AppIcon("assets/icons/favorite_active.svg"),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: AppIcon("assets/icons/cart.svg"),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: AppIcon("assets/icons/notification.svg"),
              activeIcon: AppIcon("assets/icons/notification_active.svg"),
              label: "",
            ),
            // Sửa lỗi const ở đây
            BottomNavigationBarItem(
              icon: const Icon(Icons.person_outline, color: AppColors.border),
              activeIcon: const Icon(Icons.person, color: AppColors.primary),
              label: "",
            ),
          ],
        ),
      ),
    );
  }
}
