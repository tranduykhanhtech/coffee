import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/constants/constants.dart';

class PromoBanner extends StatelessWidget{
  const PromoBanner ({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: 210.h, // Đẩy nó cách nóc 210px để nó thò xuống dưới mép nền đen
        left: 24.w, // Căn lề trái
        right: 24.w, // Căn lề phải
        child: Container(
            width: 327.w,
            height: 140.h,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: DecorationImage(
                  image: AssetImage("assets/images/banner.png"),
                  fit: BoxFit.cover
                )
            ),
            child: Padding(
              padding: EdgeInsetsGeometry.symmetric(horizontal: 24.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 13.h,),
                  Container(
                    width: 60.w,
                    height: 26.h,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Color(0xFFED5151)
                    ),
                    child: AppText.small("Promo", color: Colors.white,fontWeight: FontWeight.bold,),
                  ),
                  SizedBox(height: 8.h,),
                  // Dòng 1: Buy one get
                  Stack(
                    children: [
                      Positioned(
                        top: 15.h, // Điều chỉnh để nền đen nằm hơi lệch xuống dưới chữ
                        child: Container(
                          width: 200.w,
                          height: 27.h,
                          color: Colors.black,
                        ),
                      ),
                      AppText.big("Buy one get", color: Colors.white),
                    ],
                  ),
                  // Dòng 2: one FREE
                  Stack(
                    children: [
                      Positioned(
                        top: 15.h, // Điều chỉnh để nền đen nằm hơi lệch xuống dưới chữ
                        child: Container(
                          width: 150.w, // Độ rộng ngắn hơn dòng 1
                          height: 27.h,
                          color: Colors.black,
                        ),
                      ),
                      AppText.big("one FREE", color: Colors.white),
                    ],
                  ),
                ],
              ),
            )
        )
    );
  }

}