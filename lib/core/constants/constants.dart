import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  // Không cho phép khởi tạo class này
  AppColors._();

  static const Color primary = Color(0xFFC67C4E);      // 01: Nâu cam (Màu chủ đạo, nút bấm)
  static const Color primaryLight = Color(0xFFEDD6C8); // 02: Nâu nhạt (Nền phụ, hiệu ứng)
  static const Color textMain = Color(0xFF313131);     // 03: Xám đậm (Chữ chính, tiêu đề)
  static const Color border = Color(0xFFA2A2A2);       // 04: Xám nhạt (Đường viền, line)
  static const Color background = Color(0xFFF9F2ED);   // 05: Trắng ngà (Nền toàn app)
  static const Color error = Color(0xFFED5151);        // Màu đỏ lỗi / Promo tag
}

class AppConstants {
  AppConstants._();

  // Tên các bucket trên Supabase Storage
  static const String bucketProducts = 'menu_images';
  
  // File name của banner mặc định
  static const String defaultBannerName = 'banner.png';
}

class AppSizes {
  AppSizes._();

  // Dùng kiểu getter (get) thay vì gán cứng bằng dấu =
  // Trả về số gốc (double nguyên thủy), chưa tính screenutil vội.
  static double get defaultPadding => 24.0;

  // Khi nào cần dùng UI, ta mới gọi .w (vì đây là horizontal)
  static EdgeInsets get screenPadding => EdgeInsets.symmetric(horizontal: defaultPadding.w);

  // Tiện tay làm thêm cái vertical nếu cần
  static EdgeInsets get screenPaddingVertical => EdgeInsets.symmetric(vertical: defaultPadding.h);
}

class AppText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final int? maxLines;
  final TextOverflow? overflow;
  final TextAlign? textAlign;

  const AppText(
    this.text,
    {
      this.fontSize,
      this.fontWeight,
      this.color,
      super.key,
      this.maxLines,
      this.overflow,
      this.textAlign,
    }
  );

  const AppText.big(
    this.text,{
      super.key,
      this.fontSize = 32,
      this.fontWeight = FontWeight.w600,
      this.color = AppColors.textMain,
      this.maxLines,
      this.overflow,
      this.textAlign
    }
  );

  const AppText.medium(
    this.text,{
      super.key,
      this.fontSize = 16,
      this.fontWeight = FontWeight.w600,
      this.color = AppColors.textMain,
      this.maxLines,
      this.overflow,
      this.textAlign
    }
  );

  const AppText.small(
    this.text,{
      super.key,
      this.fontSize = 14,
      this.fontWeight = FontWeight.normal,
      this.color = AppColors.border,
      this.maxLines,
      this.overflow,
      this.textAlign
    }
  );

  const AppText.tiny(
    this.text,{
      super.key,
      this.fontSize = 12,
      this.fontWeight = FontWeight.w600,
      this.color = AppColors.primary,
      this.maxLines,
      this.overflow,
      this.textAlign
    }
  );


  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      style: GoogleFonts.sora(
          fontSize: fontSize?.sp,
          fontWeight: fontWeight,
          color: color
      ),
    );
  }

}