import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/constants/constants.dart';
import 'notification_card.dart';

class NotificationList extends StatelessWidget {
  const NotificationList({super.key});

  @override
  Widget build(BuildContext context) {
    // sau này kết nối db thì duyệt danh sách phần tử trả về rồi chạy
    // vòng lặp gọi widget NotificationCard để tạo dữ liệu cho từng phần tử
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText.medium("Today", color: AppColors.border),
        SizedBox(height: 11.h),
        Wrap(
          runSpacing: 11.h,
          children: const [
            NotificationCard(
              title: "Order on the way",
              description: "Your Caffe Mocha will arrive in 10 minutes.",
              time: "2m ago",
              iconPath: "assets/icons/noti_delivery.svg",
              isUnread: true
            ),
            NotificationCard(
              title: "Buy one get one FREE",
              description: "Promo ends tonight. Don't miss your free cup!",
              time: "1h ago",
              iconPath: "assets/icons/noti_tag.svg",
              isUnread: true,
            ),
          ],
        ),
        SizedBox(height: 11.h),
        AppText.medium("Yesterday", color: AppColors.border),
        SizedBox(height: 11.h),
        Wrap(
          runSpacing: 11.h,
          children: const [
            NotificationCard(
              title: "Order on the way",
              description: "Your Caffe Mocha will arrive in 10 minutes.",
              time: "2m ago",
              iconPath: "assets/icons/noti_cart.svg",
            ),
            NotificationCard(
              title: "Rate your experience",
              description: "How was your Flat White? Leave a review.",
              time: "1d ago",
              iconPath: "assets/icons/noti_star.svg",
            ),
            NotificationCard(
              title: "Rate your experience",
              description: "How was your Flat White? Leave a review.",
              time: "1d ago",
              iconPath: "assets/icons/noti_star.svg",
            ),
            NotificationCard(
              title: "Rate your experience",
              description: "How was your Flat White? Leave a review.",
              time: "1d ago",
              iconPath: "assets/icons/noti_star.svg",
            ),
          ],
        ),
      ],
    );
  }
}
