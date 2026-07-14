import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/constants.dart';
import '../../../../../core/widgets/app_icon.dart';

class CoffeeCart extends StatelessWidget{
  final String imageUrl;
  final String name;
  final String subName;
  final double price;


  const CoffeeCart(
    this.imageUrl,
    this.name,
    this.subName,
    this.price,
    {super.key}
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: 156.w,
      height: 238.h,
      padding: EdgeInsets.only(left: 8.w, right: 8.w, top: 8.h, bottom: 12.h),
      child: Column(
        children: [
          Container(
            width: 140.w,
            height: 128.h,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(image: AssetImage(imageUrl),
                    fit: BoxFit.cover
                )
            ),
          ),
          SizedBox(height: 8.h,),
          SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText.medium(name),
                AppText.tiny(subName, color: AppColors.border,),
              ],
            ),
          ),
          SizedBox(height: 8.h,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText("\$ $price", fontSize: 18.sp,fontWeight: FontWeight.bold,),
              AppIcon("assets/icons/add.svg")
            ],
          )

        ],
      ),
    );
  }

}