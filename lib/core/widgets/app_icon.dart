import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppIcon extends StatelessWidget{
  final String iconPath;
  final Color? color;
  final double? size;

  const AppIcon(
    this.iconPath,{
      this.color,
      this.size,
      super.key,
    }
  );

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      iconPath,
      width: size?.w ?? 24.w,
      height: size?.w ?? 24.w,
      // đổi màu cho icon SVG bằng ColorFilter
      colorFilter: color != null
        ? ColorFilter.mode(color!, BlendMode.srcIn)
        : null,
    );
  }
}