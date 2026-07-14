
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'coffee_cart.dart';

class CoffeeGrid extends StatelessWidget{
  const CoffeeGrid({super.key});

  @override
  Widget build(BuildContext context) {
    // sau này kết nối với db thì lấy danh sách dữ liệu, duyệt các phần tử rồi đổ lên giao diện
    return
      Wrap( // dùng để tự động đẩy các phần tử xuống hàng
      spacing: 15.w, // khoảng cách giữa các phần tử trên cùng 1 hàng
      runSpacing: 24.h, // cũng giống spacing...nhưng là theo chiều dọc
      children: [
        // thẻ sản phẩm
        CoffeeCart(
            "assets/images/mocha.png",
            "Caffe Mocha",
            "Deep Foam",
            4.53
        ),
        CoffeeCart(
            "assets/images/mocha.png",
            "Caffe Mocha",
            "Deep Foam",
            4.53
        ),
        CoffeeCart(
            "assets/images/mocha.png",
            "Caffe Mocha",
            "Deep Foam",
            4.53
        ),
        CoffeeCart(
            "assets/images/mocha.png",
            "Caffe Mocha",
            "Deep Foam",
            4.53
        ),
        CoffeeCart(
            "assets/images/mocha.png",
            "Caffe Mocha",
            "Deep Foam",
            4.53
        ),
        CoffeeCart(
            "assets/images/mocha.png",
            "Caffe Mocha",
            "Deep Foam",
            4.53
        ),
      ],
    );
  }
}