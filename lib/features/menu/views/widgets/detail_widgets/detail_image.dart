import 'package:coffee/core/widgets/custom_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailImage extends StatelessWidget {
  final String imageUrl;
  const DetailImage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return CustomImage(
      width: double.infinity,
      height: 202.h,
      imageUrl: imageUrl,
      borderRadius: BorderRadius.circular(16.r),
    );
  }
}
