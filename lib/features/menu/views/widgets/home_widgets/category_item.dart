import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/constants/constants.dart';

class CategoryItem extends StatelessWidget{
  final String _category;
  final bool _isSelected;

  const CategoryItem (
    this._category,
    this._isSelected,{
      super.key,
    }
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: _isSelected ? AppColors.primary : Color(0xFFEDEDED),
      ),
      child: AppText.small(
        _category,
        color: _isSelected ? Colors.white : Colors.black,
        fontWeight: FontWeight.bold,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}