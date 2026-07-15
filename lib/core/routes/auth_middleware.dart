import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../services/auth_service.dart';
import 'app_pages.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    final authService = Get.find<AuthService>();
    
    if (!authService.isLoggedIn) {
      // Nếu chưa đăng nhập, chuyển hướng về trang Login
      return const RouteSettings(name: Routes.LOGIN);
    }
    
    return null;
  }
}
