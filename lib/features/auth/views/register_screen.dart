import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants.dart';
import '../../../core/widgets/auth_header.dart';
import '../../../core/widgets/auth_input.dart';
import '../../../core/widgets/primary_button.dart';

class RegisterScreen extends StatelessWidget{
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: AppSizes.screenPadding,
          child: Column(
            children: [
              AuthHeader(
                title: "Create Account",
                subtitle: "Join our specialty community today.",
              ),
              SizedBox(height: 50.h),
              AuthInput(
                label: "Email Address",
                hintText: "yourname@domain.com",
                inputType: TextInputType.emailAddress,
              ),
              SizedBox(height: 10.h),
              AuthInput(
                label: "Password",
                hintText: "Create a password",
                isPassword: true,
              ),
              SizedBox(height: 10.h),
              AuthInput(
                label: "Confirm password",
                hintText: "Confirm a password",
                isPassword: true,
              ),
              const Spacer(),
              SizedBox(height: 30.h),
              // Sign up button
              PrimaryButton(
                buttonContext: 'Sign Up',
                onPressed: () {},
              ),
              SizedBox(height: 26.h),
              // Sign up with Google
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: (){},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.background,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      side: const BorderSide(color: AppColors.border),
                    ),
                    elevation: 0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.network('https://tse2.mm.bing.net/th/id/OIP.jYUEQ5iDArrERw6TrwY5xwHaHk?r=0&rs=1&pid=ImgDetMain&o=7&rm=3',
                        width: 24.w,
                        height: 24.h,
                      ),
                      SizedBox(width: 12.w),
                      AppText.medium("Sign Up with Google"),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 26.h),
              // Create account
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppText(
                    "Have an account? ",
                    fontSize:  14.sp,
                    fontWeight:  FontWeight.normal,
                    color:  AppColors.border,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: AppText(
                      "Sign In now",
                      fontSize:  14.sp,
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