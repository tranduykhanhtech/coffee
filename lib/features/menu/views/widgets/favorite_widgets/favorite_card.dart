import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/constants.dart';
import '../../../../../core/widgets/app_icon.dart';

class FavoriteCard extends StatelessWidget {
  final String title;
  final String subTitle;
  final String imageUrl;

  const FavoriteCard({super.key, required this.title, required this.subTitle, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 327.w,
      height: 112.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        //boxShadow: BoxShadow
      ),
      child: Row(
        children: [
          Container( // bọc ảnh
            width: 87.w,
            height: 80.h,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: DecorationImage(
                    image: AssetImage(imageUrl),
                    fit: BoxFit.cover
                )
            ),
          ),
          SizedBox(width: 11.w,),
          Container( // text và icon của card
              alignment: Alignment.center,
              child: Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText.medium(title),
                      SizedBox(height: 4.h,),
                      AppText.tiny(subTitle)
                    ],
                  ),
                  SizedBox(width: 80.w,),
                  AppIcon("assets/icons/favorite_outline.svg",),
                ],
              )
          ),
        ],
      ),
    );
  }

}