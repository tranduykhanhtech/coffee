import 'package:coffee/core/constants.dart';
import 'package:coffee/core/widgets/app_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderAddressSection extends StatelessWidget {
  const OrderAddressSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 121.h, // h: 121
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText.medium("Delivery Address", color: Colors.black),
          SizedBox(height: 16.h), // cách Delivery Address 16
          AppText(
            "Tran Duy Khanh",
            fontSize: 14.sp, // small
            fontWeight: FontWeight.w600, // semibold
            color: Colors.black,
          ),
          SizedBox(height: 4.h), // cách tên ở trên là 4
          AppText.tiny(
            "289 Nguyen Thai Sơn, An Nhon, Ho Chi Minh City",
            fontWeight: FontWeight.normal,
            color: AppColors.border,
          ),
          const Spacer(),
          Row(
            children: [
              // Nút Edit Address
              _AddressButton(
                label: "Edit Address",
                iconPath: "assets/icons/edit_addr.svg",
                //width: 120,
              ),
              SizedBox(width: 8.w),
              // Nút Add Note
              _AddressButton(
                label: "Add Note",
                iconPath: "assets/icons/add_note.svg",
                //width: 101,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _AddressButton extends StatelessWidget {
  final String label;
  final String iconPath;
  //final double width;

  const _AddressButton({
    required this.label,
    required this.iconPath,
    //required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      //width: width.w,
      //height: 26.h,
      padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 10.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.border, width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AppIcon(iconPath, size: 14), // icon 14x14
          SizedBox(width: 4.w), // cách icon trái là 4
          AppText.tiny(label, fontWeight: FontWeight.normal,color: Colors.black,),
        ],
      ),
    );
  }
}
