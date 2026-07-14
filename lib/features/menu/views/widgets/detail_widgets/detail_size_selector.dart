import 'package:coffee/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailSizeSelector extends StatefulWidget {
  const DetailSizeSelector({super.key});

  @override
  State<DetailSizeSelector> createState() => _DetailSizeSelectorState();
}

class _DetailSizeSelectorState extends State<DetailSizeSelector> {
  String selectedSize = "M";
  final List<String> sizes = ["S", "M", "L"];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 81.h, // Chiều cao theo yêu cầu
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText.medium("Size"),
          SizedBox(height: 16.h), // cách các lựa chọn 16
          Row(
            children: sizes.map((size) {
              final isSelected = selectedSize == size;
              return Padding(
                padding: EdgeInsets.only(right: size != sizes.last ? 16.w : 0),
                child: GestureDetector(
                  onTap: () => setState(() => selectedSize = size),
                  child: Container(
                    width: 96.w, // w: 96
                    height: 41.h, // h: 41
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.primaryLight.withOpacity(0.2) : Colors.white,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(
                        color: isSelected ? AppColors.primary : AppColors.border.withOpacity(0.3),
                      ),
                    ),
                    child: Center(
                      child: AppText(
                        size,
                        fontSize: 14.sp, // small
                        color: isSelected ? AppColors.primary : AppColors.textMain,
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
