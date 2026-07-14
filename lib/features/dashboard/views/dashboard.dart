import 'package:coffee/features/menu/views/favorite_screen.dart';
import 'package:coffee/features/menu/views/home_screen.dart';
import 'package:coffee/features/notifications/views/notification_screen.dart';
import 'package:coffee/features/orders/views/cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    const NotificationScreen(), // Đổi CartScreen thành một màn hình khác hoặc để trống
  ];

  void _changeScreen(int index) {
    if (index == 2) {
      // Nếu bấm vào giỏ hàng (Cart), điều hướng Navigator.push để ẩn BottomBar
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const CartScreen()),
      );
      return; // Không đổi selectedIndex của BottomBar
    }
    
    // Xử lý index cho các màn hình còn lại (Home, Favorite, Notification)
    // Vì ta đã lấy index 2 làm CartScreen (push riêng), 
    // nên cần điều chỉnh index để khớp với danh sách _page
    int actualIndex = index;
    if (index > 2) {
      actualIndex = 2; // Index 3 (Notification) trỏ về phần tử thứ 2 của _page
    }
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex > 2 ? 2 : _selectedIndex, 
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
          backgroundColor: Colors.transparent, // Đặt trong suốt để hiển thị màu của Container
          elevation: 0,
          type: BottomNavigationBarType.fixed, // không cho icon nhảy lung tung
          showSelectedLabels: false, // Tắt hẳn chỗ dành cho chữ của nút Active
          showUnselectedLabels: false, // Tắt hẳn chỗ dành cho chữ của nút Inactive
          //////////////////////////////////////////////////////////////////////////
          currentIndex: _selectedIndex,
          onTap: _changeScreen,
          selectedItemColor: Colors.red,
          unselectedItemColor: Colors.blue,
          items: [
            BottomNavigationBarItem(
              icon: AppIcon("assets/icons/home.svg",),
              activeIcon: AppIcon("assets/icons/home_active.svg"),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: AppIcon("assets/icons/favorite.svg",),
              activeIcon: AppIcon("assets/icons/favorite_active.svg",),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: AppIcon("assets/icons/cart.svg",),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: AppIcon("assets/icons/notification.svg",),
              activeIcon: AppIcon("assets/icons/notification_active.svg",),
              label: "",
            ),
          ],
        ),
      ),
    );
  }
}
