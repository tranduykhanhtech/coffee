import 'package:get/get.dart';
import '../../features/auth/views/login_screen.dart';
import '../../features/auth/views/verify_otp_screen.dart';
import '../../features/dashboard/views/dashboard.dart';
import '../../features/menu/views/home_screen.dart';
import '../../features/menu/views/item_detail_screen.dart';
import '../../features/menu/views/favorite_screen.dart';
import '../../features/orders/views/cart_screen.dart';
import '../../features/orders/views/order_screen.dart';
import '../../features/notifications/views/notification_screen.dart';
import '../../features/profile/views/payment_method_screen.dart';
import '../../features/profile/views/profile_screen.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.DASHBOARD;

  static final routes = [
    GetPage(
      name: _Paths.DASHBOARD,
      page: () => const Dashboard(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginScreen(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeScreen(),
    ),
    GetPage(
      name: _Paths.ITEM_DETAIL,
      page: () => const ItemDetailScreen(),
    ),
    GetPage(
      name: _Paths.CART,
      page: () => const CartScreen(),
    ),
    GetPage(
      name: _Paths.ORDER,
      page: () => const OrderScreen(),
    ),
    GetPage(
      name: _Paths.NOTIFICATION,
      page: () => const NotificationScreen(),
    ),
    GetPage(
      name: _Paths.FAVORITE,
      page: () => const FavoriteScreen(),
    ),
    GetPage(
      name: _Paths.PAYMENT_METHOD,
      page: () => const PaymentMethodScreen(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileScreen(),
    ),
    GetPage(
      name: _Paths.VERIFY_OTP,
      page: () => VerifyOtpScreen(
        email: Get.arguments['email'],
        userName: Get.arguments['userName'],
        displayName: Get.arguments['displayName'],
        password: Get.arguments['password'],
      ),
    ),
  ];
}
