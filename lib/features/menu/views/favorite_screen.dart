import 'package:coffee/core/constants/constants.dart';
import 'package:coffee/core/widgets/app_bar.dart';
import 'package:coffee/features/menu/views/widgets/favorite_widgets/favorite_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FavoriteScreen extends StatelessWidget{
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: AppSizes.screenPadding,
              child: Column(
                children: [
                  const AppBarCoffee(title: "Favorite"),
                  Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(
                          children: [
                            // hiển thị danh sách sản phẩm yêu thích
                            SizedBox(height: 24.h,),
                            FavoriteList()
                          ],
                        ),
                      ),
                  )

                ],
              ),
            )
          ],
        ),
      )

    );
  }

}