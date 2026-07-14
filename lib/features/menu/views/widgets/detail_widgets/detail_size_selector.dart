import 'package:coffee/features/menu/models/product_size_model.dart';
import 'package:coffee/core/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailSizeSelector extends StatefulWidget {
  final List<ProductSizeModel> availableSizes; // Danh sách size lấy từ DB
  final Function(ProductSizeModel) onSizeSelected; // Trả về object Size thay vì chỉ là text

  const DetailSizeSelector({
    super.key,
    required this.availableSizes,
    required this.onSizeSelected,
  });

  @override
  State<DetailSizeSelector> createState() => _DetailSizeSelectorState();
}

class _DetailSizeSelectorState extends State<DetailSizeSelector> {
  String? selectedSizeId;

  @override
  void initState() {
    super.initState();
    // Mặc định chọn size đầu tiên (thường là S hoặc M tùy DB)
    if (widget.availableSizes.isNotEmpty) {
      selectedSizeId = widget.availableSizes.first.id;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 81.h,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText.medium("Size"),
          SizedBox(height: 16.h),
          // Bọc Row trong SingleChildScrollView ngang để tránh lỗi tràn màn hình (Overflow)
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: Row(
              children: widget.availableSizes.map((sizeObj) {
                final isSelected = selectedSizeId == sizeObj.id;
                return Padding(
                  padding: EdgeInsets.only(right: 16.w),
                  child: GestureDetector(
                    onTap: () {
                      setState(() => selectedSizeId = sizeObj.id);
                      widget.onSizeSelected(sizeObj);
                    },
                    child: Container(
                      width: 96.w,
                      height: 41.h,
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.primaryLight.withOpacity(0.2) : Colors.white,
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                          color: isSelected ? AppColors.primary : AppColors.border.withOpacity(0.3),
                        ),
                      ),
                      child: Center(
                        child: AppText(
                          sizeObj.sizeType ?? "",
                          fontSize: 14.sp,
                          color: isSelected ? AppColors.primary : AppColors.textMain,
                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
