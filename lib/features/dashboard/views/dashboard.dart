import 'package:coffee/core/routes/app_pages.dart';
import 'package:coffee/core/services/auth_service.dart';
import 'package:coffee/features/profile/views/profile_screen.dart';
import 'package:get/get.dart';
import 'package:coffee/features/menu/views/favorite_screen.dart';
import 'package:coffee/features/menu/views/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constants/constants.dart';
import '../../../core/widgets/app_icon.dart';
import '../../orders/views/order_history_screen.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _selectedIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _mapIndexToPage(_selectedIndex));

    // Kiểm tra xem có yêu cầu mở tab cụ thể nào không (ví dụ sau khi đặt hàng thành công)
    if (Get.arguments != null && Get.arguments is int) {
      _selectedIndex = Get.arguments;
      // Nếu có argument, ta cần delay một chút để PageView khởi tạo xong mới nhảy trang được
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _pageController.jumpToPage(_mapIndexToPage(_selectedIndex));
      });
    }
  }

  // Helper để map index của BottomNav sang index của PageView (bỏ qua Cart index 2)
  int _mapIndexToPage(int index) {
    if (index < 2) return index;
    if (index > 2) return index - 1;
    return 0; // Fallback
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  final List<Widget> _page = [
    const HomeScreen(),
    const FavoriteScreen(),
    const OrderHistoryScreen(),
    const ProfileScreen(),
  ];

  void _changeScreen(int index) {
    final authService = Get.find<AuthService>();

    // Kiểm tra quyền truy cập cho các tab được bảo vệ
    // Theo yêu cầu: Favorite (1) và Cart (2 - Route riêng) cho phép Guest (do có Local Store)
    // Chỉ bảo vệ: History (3) và Profile (4)
    if (index >= 3 && !authService.isLoggedIn) {
      Get.toNamed(Routes.LOGIN);
      return;
    }

    if (index == 2) {
      Get.toNamed(Routes.CART);
      return;
    }
    
    // Đã loại bỏ việc tự động gọi refresh ở đây để tránh load thừa mỗi khi đổi tab
    // Dữ liệu sẽ được Controller chủ động yêu cầu load khi cần thiết (ví dụ sau khi đặt hàng)

    setState(() {
      _selectedIndex = index;
    });

    // Sử dụng animateToPage để có hiệu ứng chuyển trang mượt mà
    _pageController.animateToPage(
      _mapIndexToPage(index),
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(), // Chặn vuốt tay để dùng Nav Bar điều khiển
        children: _page,
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
              icon: const AppIcon("assets/icons/home.svg"),
              activeIcon: const AppIcon("assets/icons/home_active.svg"),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: const AppIcon("assets/icons/favorite.svg"),
              activeIcon: const AppIcon("assets/icons/favorite_active.svg"),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: const AppIcon("assets/icons/cart.svg"),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: const AppIcon("assets/icons/notification.svg"),
              activeIcon: const AppIcon("assets/icons/notification_active.svg"),
              label: "History",
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.person_outline, color: AppColors.border, size: 48,),
              activeIcon: const Icon(Icons.person, color: AppColors.primary, size: 48),
              label: "",
            ),
          ],
        ),
      ),
    );
  }
}
