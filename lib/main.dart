import 'package:coffee/core/repository/cart_repository.dart';
import 'package:coffee/core/repository/favorite_repository.dart';
import 'package:coffee/core/repository/user_repository.dart';
import 'package:coffee/features/dashboard/views/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'core/constants/api_keys.dart';
import 'core/supabase_client.dart';
import 'core/services/auth_service.dart';
import 'core/services/cart_service.dart';
import 'core/services/favorite_service.dart';
import 'core/services/payment_service.dart';
import 'features/auth/controllers/auth_controller.dart';
import 'features/auth/repository/auth_repository.dart';
import 'features/orders/controllers/order_history_controller.dart';
import 'features/orders/repository/order_repository.dart';
import 'core/repository/payment_repository.dart';
import 'features/profile/controllers/profile_controller.dart';
import 'core/routes/app_pages.dart';
import 'core/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Khởi tạo GetStorage theo quan_ly_data.md
  await GetStorage.init();

  // load file env trươớc
  await dotenv.load(fileName: ".env");

  // rồi mới khởi tạo supabase thông qua config tập trung
  await SupabaseConfig.init();

  // Khởi tạo Stripe cho Sandbox
  Stripe.publishableKey = ApiKeys.stripePublishableKey;
  await Stripe.instance.applySettings();

  // Đưa các Service/Repository vào bộ nhớ để dùng xuyên suốt app
  // THỨ TỰ QUAN TRỌNG: Repository phải được khởi tạo TRƯỚC Service/Controller
  
  // 1. Đăng ký Repositories trước
  Get.put(AuthRepository());
  Get.put(UserRepository());
  Get.put(CartRepository());
  Get.put(FavoriteRepository());
  Get.put(OrderRepository());
  Get.put(PaymentRepository());

  // 2. Sau đó mới đăng ký Services và Controllers (những thứ cần Repo)
  Get.put(AuthService());
  Get.put(AuthController(repository: Get.find<AuthRepository>()));
  Get.put(ProfileController(repository: Get.find<UserRepository>()));
  Get.put(CartService());
  Get.put(FavoriteService());
  Get.put(PaymentService());
  Get.put(OrderHistoryController(repository: Get.find<OrderRepository>()));

  // chạy app
  runApp(const CoffeeApp());
}

class CoffeeApp extends StatelessWidget {
  const CoffeeApp({super.key});

  @override
  Widget build(BuildContext context ) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          title: "CoBrew App",
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          initialRoute: AppPages.INITIAL,
          getPages: AppPages.routes,
        );
      },
      child: const Dashboard(),
    );
  }
}