import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/constants.dart';
import 'category_item.dart';

class CategorySelector extends StatelessWidget{
  const CategorySelector({super.key});

  @override
  Widget build(BuildContext context) {
    // sau này kết nối db thì dùng ListView.separated() để khỏi bị lag và duyệt từng phần tử để đổ lên giao diện
    return Container(
        padding: AppSizes.screenPadding,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            spacing: 16.w,
            children: [
              CategoryItem("All Coffee", true),
              CategoryItem("Machiato", false),
              CategoryItem("Latte", false),
              CategoryItem("Americano", false),
            ],
          ),
        )
    );
  }
}