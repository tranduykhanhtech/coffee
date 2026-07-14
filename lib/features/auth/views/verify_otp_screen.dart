import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/constants/constants.dart';
import '../../../core/widgets/app_bar.dart';
import '../../../core/widgets/auth_header.dart';
import '../../../core/widgets/auth_input.dart';
import '../../../core/widgets/primary_button.dart';
import '../controllers/auth_controller.dart';

class VerifyOtpScreen extends StatelessWidget {
  final String email;
  final String userName;
  final String displayName;
  final String password;

  VerifyOtpScreen({
    super.key,
    required this.email,
    required this.userName,
    required this.displayName,
    required this.password,
  });

  final TextEditingController otpController = TextEditingController();
  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: AppSizes.screenPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AuthHeader(
                title: "Verify OTP",
                subtitle: "We have sent a verification code to your email.",
              ),
              SizedBox(height: 50.h),
              AuthInput(
                label: "OTP Code",
                hintText: "Enter 6-digit code",
                controller: otpController,
                inputType: TextInputType.number,
              ),

              SizedBox(height: 16.h),

              // Cụm nút Gửi lại mã OTP với Countdown 30s
              Obx(() => Center(
                child: authController.countdown.value > 0
                    ? AppText(
                        "Resend code in ${authController.countdown.value}s",
                        fontSize: 14.sp,
                        color: AppColors.border,
                      )
                    : GestureDetector(
                        onTap: () => authController.resendOTP(email),
                        child: AppText(
                          "Resend OTP",
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
              )),

              const Spacer(),
              Obx(() => PrimaryButton(
                buttonContext: authController.isLoading.value ? "Verifying..." : "Verify",
                onPressed: authController.isLoading.value
                    ? null
                    : () {
                        authController.completeSignUp(
                          email: email,
                          token: otpController.text.trim(),
                          userName: userName,
                          displayName: displayName,
                        );
                      },
              )),
              SizedBox(height: 26.h),
              // Nút quay lại đăng nhập kiểu Text Link cho đúng style Login/Register của ô
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppText(
                    "Already have an account? ",
                    fontSize: 14.sp,
                    fontWeight: FontWeight.normal,
                    color: AppColors.border,
                  ),
                  GestureDetector(
                    onTap: () => Get.offAllNamed('/login'), // Hoặc dùng Routes.LOGIN nếu đã import
                    child: AppText(
                      "Sign In",
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 50.h),
            ],
          ),
        ),
      ),
    );
  }
}
