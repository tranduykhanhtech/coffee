import 'package:coffee/core/constants/api_keys.dart';
import 'package:coffee/core/repository/cart_repository.dart';
import 'package:coffee/core/repository/favorite_repository.dart';
import 'package:coffee/features/dashboard/views/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'core/services/auth_service.dart';
import 'core/services/cart_service.dart';
import 'core/services/favorite_service.dart';
import 'features/auth/controllers/auth_controller.dart';
import 'features/auth/repository/auth_repository.dart';
import 'features/orders/repository/order_repository.dart';
import 'core/routes/app_pages.dart';
import 'core/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Khởi tạo GetStorage theo quan_ly_data.md
  await GetStorage.init();

  // load file env trươớc
  await dotenv.load(fileName: ".env");

  // rồi mới khởi tạo supabase
  await Supabase.initialize(
    url: ApiKeys.supabaseUrl,
    anonKey: ApiKeys.supabasePublishableKey,
  );

  // Đưa các Service/Repository vào bộ nhớ để dùng xuyên suốt app
  // THỨ TỰ QUAN TRỌNG: Repository phải được khởi tạo TRƯỚC Service/Controller
  
  // 1. Đăng ký Repositories trước
  Get.put(AuthRepository());
  Get.put(CartRepository());
  Get.put(FavoriteRepository());
  Get.put(OrderRepository());

  // 2. Sau đó mới đăng ký Services và Controllers (những thứ cần Repo)
  Get.put(AuthService());
  Get.put(AuthController(repository: Get.find<AuthRepository>()));
  Get.put(CartService());
  Get.put(FavoriteService());

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