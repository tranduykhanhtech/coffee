import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constants.dart';
import '../../../core/widgets/auth_header.dart';
import '../../../core/widgets/auth_input.dart';
import '../../../core/widgets/primary_button.dart';
import 'register_screen.dart';
import 'forgot_password_screen.dart';

class LoginScreen extends StatelessWidget{
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: AppSizes.screenPadding,
          child: Column(
            children: [
              AuthHeader(
                title: "Welcome back",
                subtitle: "Sign In to continue your coffee journey.",
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
              Container(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ForgotPasswordScreen(),
                      ),
                    );
                  },
                  child: AppText(
                    "Forgot Password?",
                    fontSize: 14.sp,
                    fontWeight:  FontWeight.normal,
                    color:  AppColors.primary,
                  ),
                ),
              ),
              const Spacer(),
              SizedBox(height: 30.h),
              // Login button
              PrimaryButton(
                buttonContext: 'Sign In',
                onPressed: () {

                },
              ),
              SizedBox(height: 26.h),
              // Login with Google
              SizedBox(
                width: double.infinity,
                height: 56.h,
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
                      AppText.medium("Sign In with Google"),
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
                    "Don't have an account? ",
                    fontSize: 14.sp,
                    fontWeight:  FontWeight.normal,
                    color:  AppColors.border,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RegisterScreen()
                        ),
                      );
                    },
                    child: AppText(
                      "Sign Up now",
                      fontSize: 14.sp,
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