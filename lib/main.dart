import 'package:coffee/features/dashboard/views/dashboard.dart';
import 'package:coffee/features/menu/views/item_detail_screen.dart';
import 'package:coffee/features/orders/views/order_screen.dart';
import 'package:coffee/features/profile/views/payment_method_screen.dart';
import 'package:coffee/features/profile/views/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/app_theme.dart';

void main(){
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
        return MaterialApp(
          title: "ca phe phe phe hehe",
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          home: child,
        );
      },
      child: const OrderScreen(),
    );
  }
}