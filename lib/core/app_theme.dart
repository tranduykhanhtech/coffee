
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'constants/constants.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get lightTheme {
    return ThemeData(
      // 1. Set màu nền mặc định cho mọi màn hình
      scaffoldBackgroundColor: Color(0xFFF9F9F9),
      primaryColor: AppColors.primary,

      // 2. Set Font Sora làm font mặc định, và ép màu chữ chính là textMain
      textTheme: GoogleFonts.soraTextTheme().apply(
        bodyColor: AppColors.textMain,
        displayColor: AppColors.textMain,
      ),

      // 3. Cấu hình bảng màu tổng thể (rất quan trọng để các widget mặc định ăn theo)
      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        secondary: AppColors.primaryLight,
        surface: AppColors.background,
        onPrimary: Colors.white, // Chữ trên nền primary sẽ là màu trắng
      ),

      // 4. (Bonus) Cấu hình mặc định cho AppBar luôn
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFFF9F9F9),
        elevation: 0, // Bỏ bóng mờ
        iconTheme: IconThemeData(color: AppColors.textMain),
        centerTitle: true,
      ),
    );
  }
}