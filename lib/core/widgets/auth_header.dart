import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../constants/constants.dart';


class AuthHeader extends StatelessWidget{
  final String title;
  final String subtitle;

  const AuthHeader({
    super.key,
    required this.title,
    required this.subtitle
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 34.h),
        SizedBox(
          width: double.infinity,
          height: 77.h,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText.big(title),
              SizedBox(height: 8.h),
              Flexible(
                  child: AppText.small(
                      subtitle
                  ),
              )

            ],
          ),
        ),
      ],
    );
  }
}