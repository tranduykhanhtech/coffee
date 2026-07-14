import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/constants.dart';
import '../../../core/widgets/auth_header.dart';
import '../../../core/widgets/auth_input.dart';
import '../../../core/widgets/primary_button.dart';

class ForgotPasswordScreen extends StatelessWidget{
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: AppSizes.screenPadding,
          child: Column(
            children: [
              AuthHeader(
                title: "Forgot Password",
                subtitle: "Enter your email to receive a reset link.",
              ),
              SizedBox(height: 50.h),
              AuthInput(
                label: "Email Address",
                hintText: "yourname@domain.com",
                inputType: TextInputType.emailAddress,
              ),
              SizedBox(height: 27.h),
              Container(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () {},
                  child: AppText(
                    "Resend after 00:36",
                    fontSize: 14.sp,
                    fontWeight:  FontWeight.normal,
                    color:  AppColors.primary,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const Spacer(),
              SizedBox(height: 30.h),
              // Sign up button
              PrimaryButton(
                buttonContext: 'Send reset link',
                onPressed: () {

                },
              ),
              SizedBox(height: 100.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: AppText(
                      "Back to Sign In >",
                      fontSize:  14,
                      fontWeight:  FontWeight.bold,
                      color:  AppColors.primary,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 39.h),
            ],
          ),

        ),
      ),
    );
  }
}