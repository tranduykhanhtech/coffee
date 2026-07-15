import 'package:coffee/core/supabase_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/constants/constants.dart';

class PromoBanner extends StatelessWidget {
  const PromoBanner({super.key});

  @override
  Widget build(BuildContext context) {
    // Lấy link banner từ Supabase Storage thông qua Config tập trung
    final String bannerUrl = SupabaseConfig.getPublicUrl(
      AppConstants.bucketProducts,
      AppConstants.defaultBannerName,
    );

    return Positioned(
      top: 210.h, // Đẩy nó cách nóc 210px để nó thò xuống dưới mép nền đen
      left: 24.w, // Căn lề trái
      right: 24.w, // Căn lề phải
      child: Container(
        width: 327.w,
        height: 140.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Stack(
          children: [
            // Layer 1: Ảnh nền từ Network
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  bannerUrl,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                      color: Colors.grey[800],
                      child: Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primary,
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      ),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    // Khi lỗi load ảnh (ví dụ: ảnh xám như user báo), 
                    // hiện background màu tối để text vẫn đọc được
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[900],
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Center(
                        child: Icon(Icons.broken_image, color: Colors.white24, size: 40),
                      ),
                    );
                  },
                ),
              ),
            ),
            
            // Layer 2: Nội dung chữ
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 13.h),
                  Container(
                    width: 60.w,
                    height: 26.h,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: AppColors.error,
                    ),
                    child: const AppText.small(
                      "Promo",
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  // Dòng 1: Buy one get
                  Stack(
                    children: [
                      Positioned(
                        top: 15.h,
                        child: Container(
                          width: 200.w,
                          height: 27.h,
                          color: Colors.black.withAlpha(178), // 0.7 * 255 ≈ 178
                        ),
                      ),
                      const AppText.big("Buy one get", color: Colors.white),
                    ],
                  ),
                  // Dòng 2: one FREE
                  Stack(
                    children: [
                      Positioned(
                        top: 15.h,
                        child: Container(
                          width: 150.w,
                          height: 27.h,
                          color: Colors.black.withAlpha(178),
                        ),
                      ),
                      const AppText.big("one FREE", color: Colors.white),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
