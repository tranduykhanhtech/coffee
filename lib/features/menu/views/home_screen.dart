import 'package:coffee/features/menu/controllers/coffee_menu_controller.dart';
import 'package:coffee/features/menu/repository/coffee_menu_repository.dart';
import 'package:coffee/features/menu/views/widgets/home_widgets/category_selector.dart';
import 'package:get/get.dart';
import 'package:coffee/features/menu/views/widgets/home_widgets/coffee_grid.dart';
import 'package:coffee/features/menu/views/widgets/home_widgets/home_header.dart';
import 'package:coffee/features/menu/views/widgets/home_widgets/promo_banner.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Khởi tạo controller và truyền Repository thực tế để gọi dữ liệu từ Supabase
  final CoffeeMenuController controller = Get.put(
    CoffeeMenuController(repository: CoffeeMenuRepository()),
  );

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, // Làm trong suốt cái nền
        // 1. Dành cho Android: Icon màu Sáng (Trắng)
        statusBarIconBrightness: Brightness.light,

        // 2. Dành cho iOS: Background màu Tối -> Ép chữ phải thành Sáng (Trắng)
        statusBarBrightness: Brightness.dark,
      ),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              SizedBox(
                height: 353.h,
                child: Stack(
                  children: [
                    // home header
                    HomeHeader(),

                    // banner lơ lửng ảo ma Canada
                    PromoBanner(),
                  ],
                ),
              ),
              SizedBox(height: 24.h),

              //thanh lọc sản phẩm
              CategorySelector(),

              SizedBox(height: 16.h),

              // khu vực hiển thị các thẻ sản phẩm
              CoffeeGrid(),
            ],
          ),
        ),
      ),
    );
  }
}
