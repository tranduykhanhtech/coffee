import 'package:coffee/features/menu/views/widgets/favorite_widgets/favorite_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FavoriteList extends StatelessWidget{
  const FavoriteList({super.key});

  @override
  Widget build(BuildContext context) {
    // sau này có Db thì lấy data rồi chạy vòng lặp r đổ lên giao diện
    return Wrap(
      runSpacing: 14.h,
      children: [
        FavoriteCard(title: "Caffe Mocha", subTitle: "Deep Foam", imageUrl: "assets/images/mocha.png"),
        FavoriteCard(title: "Caffe Mocha", subTitle: "Deep Foam", imageUrl: "assets/images/mocha.png"),
        FavoriteCard(title: "Caffe Mocha", subTitle: "Deep Foam", imageUrl: "assets/images/mocha.png"),
        FavoriteCard(title: "Caffe Mocha", subTitle: "Deep Foam", imageUrl: "assets/images/mocha.png"),
        FavoriteCard(title: "Caffe Mocha", subTitle: "Deep Foam", imageUrl: "assets/images/mocha.png"),
        FavoriteCard(title: "Caffe Mocha", subTitle: "Deep Foam", imageUrl: "assets/images/mocha.png"),
        FavoriteCard(title: "Caffe Mocha", subTitle: "Deep Foam", imageUrl: "assets/images/mocha.png"),
        FavoriteCard(title: "Caffe Mocha", subTitle: "Deep Foam", imageUrl: "assets/images/mocha.png"),
        FavoriteCard(title: "Caffe Mocha", subTitle: "Deep Foam", imageUrl: "assets/images/mocha.png"),
        FavoriteCard(title: "Caffe Mocha", subTitle: "Deep Foam", imageUrl: "assets/images/mocha.png"),
      ],
    );
  }

}