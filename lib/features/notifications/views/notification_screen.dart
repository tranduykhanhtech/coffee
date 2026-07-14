import 'package:coffee/core/widgets/app_bar.dart';
import 'package:coffee/core/widgets/app_icon.dart';
import 'package:coffee/features/notifications/views/widgets/notification/notification_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants.dart';

class NotificationScreen extends StatelessWidget{
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: AppBarCoffee(title: "Notifications",icon: AppIcon("assets/icons/read_all.svg"),),
      // ),
      body: SafeArea(
          child: Stack(
            children: [
              Padding(
                padding: AppSizes.screenPadding,
                child: Column(
                  children: [
                    AppBarCoffee(title: "Notifications",icon: AppIcon("assets/icons/read_all.svg",size: 40,),),
                    Expanded(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Column(
                            children: [
                              SizedBox(height: 24.h,),
                              NotificationList(),
                            ],
                          ),
                        ),
                    )
                  ],
                ),
              )
            ],
          )
      )

    );
  }

}