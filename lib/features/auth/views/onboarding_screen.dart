import 'package:coffee/core/constants.dart';
import 'package:coffee/core/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>{

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, // Làm trong suốt cái nền
        // 1. Dành cho Android: Icon màu Sáng (Trắng)
        statusBarIconBrightness: Brightness.light,

        // 2. Dành cho iOS: Background màu Tối -> Ép chữ phải thành Sáng (Trắng)
        statusBarBrightness: Brightness.dark,
      ),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        body: Column(
          children: [
            Container(
              width: 375.h,
              height: 536.h,
              alignment: Alignment.bottomCenter,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/onboarding.png'),
                      fit: BoxFit.cover
                  )
              ),
              child: AppText.big(
                "Fall in Love with",
                color: Colors.white,
              ),
            ),
            Container(
              width: 375.h,
              height: 276.h,
              color: Colors.black,
              child: Column(
                children: [
                  AppText.big(
                    "Coffee in Blissful",
                    color: Colors.white,
                  ),
                  AppText.big(
                    "Delight!",
                    color: Colors.white,
                  ),
                  SizedBox(height: 8.h,),
                  AppText.small("Welcome to our cozy coffee corner, where "),
                  AppText.small("every cup is a delightful for you. "),
                  SizedBox(height: 32.h,),
                  Padding(
                    padding: AppSizes.screenPadding,
                    child: PrimaryButton(
                      buttonContext: "Get Started",
                      onPressed: () => {},
                    ),
                  )

                ],
              ),
            )
          ],
        ),
      )
    );
  }}