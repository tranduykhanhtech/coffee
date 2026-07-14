import 'package:coffee/core/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailDescription extends StatelessWidget {
  final String description;
  const DetailDescription({super.key, required this.description});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 95.h, // Chiều cao theo yêu cầu
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText.medium("Description"),
          SizedBox(height: 8.h), // cách đoạn văn 8
          RichText(
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            text: TextSpan(
              style: TextStyle(
                fontSize: 14.sp,
                fontFamily: 'Sora',
                color: AppColors.border,
                fontWeight: FontWeight.w300, // light
                height: 1.5,
              ),
              children: [
                TextSpan(
                    text: description
                ),
              ],
            ),
          ),
          Text(
            " Read More",
            style: TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.bold, // bold
            ),
          ),
        ],
      ),
    );
  }
}
