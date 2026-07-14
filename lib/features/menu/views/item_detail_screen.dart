import 'package:coffee/core/constants.dart';
import 'package:coffee/core/widgets/app_bar.dart';
import 'package:coffee/core/widgets/app_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'widgets/detail_widgets/detail_image.dart';
import 'widgets/detail_widgets/detail_info.dart';
import 'widgets/detail_widgets/detail_description.dart';
import 'widgets/detail_widgets/detail_size_selector.dart';
import 'widgets/detail_widgets/detail_bottom_bar.dart';

class ItemDetailScreen extends StatelessWidget {
  const ItemDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: AppSizes.screenPadding,
              child: Column(
                children: [
                  // Thanh AppBar cố định ở trên
                  const AppBarCoffee(
                    title: "Detail",
                    icon: AppIcon("assets/icons/favorite.svg"),
                  ),
                  // Phần nội dung chi tiết có thể cuộn
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 24.h),
                          
                          // Ảnh sản phẩm lớn (h: 202)
                          const DetailImage(imageUrl: "assets/images/mocha_thumbnail.png"),
                          
                          SizedBox(height: 16.h),
                          
                          // Khung thông tin tên, ice/hot, rating và các icon (h: 100)
                          const DetailInfo(
                            name: "Caffe Mocha",
                            subName: "Ice/Hot",
                            rating: 4.8,
                            reviewCount: 230,
                          ),

                          Divider(color: AppColors.border.withOpacity(0.2)),
                          SizedBox(height: 16.h),
                          
                          // Khung mô tả (h: 95)
                          const DetailDescription(
                            description: "A cappuccino is an approximately 150 ml (5 oz) beverage, with 25 ml of espresso coffee and 85ml of fresh milk the fo..",
                          ),
                          
                          SizedBox(height: 20.h),
                          
                          // Khung chọn Size (h: 81)
                          const DetailSizeSelector(),
                          
                          // Khoảng trống ở cuối để không bị Bottom Bar che mất
                          SizedBox(height: 140.h),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            // Khung mua hàng ở dưới cùng (h: 121)
            const Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: DetailBottomBar(price: 4.53),
            ),
          ],
        ),
      ),
    );
  }
}
