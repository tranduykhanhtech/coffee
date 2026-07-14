import 'package:coffee/features/auth/controllers/auth_controller.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constants/constants.dart';
import '../../../core/widgets/auth_header.dart';
import '../../../core/widgets/auth_input.dart';
import '../../../core/widgets/primary_button.dart';
import 'register_screen.dart';
import 'forgot_password_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  // Khai báo controller và các biến để lưu thông tin nhập liệu
  final AuthController authController = Get.find<AuthController>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Mặc định là true, bàn phím hiện lên sẽ đẩy UI lên
      resizeToAvoidBottomInset: true, 
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: ConstrainedBox(
                // Đặt chiều cao tối thiểu bằng chiều cao màn hình
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Padding(
                  padding: AppSizes.screenPadding,
                  child: IntrinsicHeight(
                    child: Column(
                      children: [
                        const AuthHeader(
                          title: "Welcome back",
                          subtitle: "Sign In to continue your coffee journey.",
                        ),
                        SizedBox(height: 50.h),
                        AuthInput(
                          label: "Email Address",
                          hintText: "yourname@domain.com",
                          inputType: TextInputType.emailAddress,
                          controller: emailController,
                        ),
                        SizedBox(height: 10.h),
                        AuthInput(
                          label: "Password",
                          hintText: "Type password",
                          isPassword: true,
                          controller: passwordController,
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
                            child: AppText.small(
                              "Forgot Password?",
                              fontWeight: FontWeight.normal,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                        
                        // Spacer() này sẽ đẩy toàn bộ phần nút xuống dưới cùng
                        const Spacer(),
                        
                        SizedBox(height: 30.h),
                        // Login button
                        Obx(() => PrimaryButton(
                          buttonContext: authController.isLoading.value ? 'Logging in...' : 'Sign In',
                          onPressed: authController.isLoading.value 
                            ? null 
                            : () {
                                authController.login(
                                  email: emailController.text.trim(),
                                  password: passwordController.text.trim(),
                                );
                              },
                        )),
                        SizedBox(height: 26.h),
                        // Login with Google
                        SizedBox(
                          width: double.infinity,
                          height: 56.h,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                                side: const BorderSide(color: AppColors.border),
                              ),
                              elevation: 0,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.network(
                                  'https://tse2.mm.bing.net/th/id/OIP.jYUEQ5iDArrERw6TrwY5xwHaHk?r=0&rs=1&pid=ImgDetMain&o=7&rm=3',
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
                            Flexible(
                              child: AppText.small(
                                "Don't have an account? ",
                                fontWeight: FontWeight.normal,
                                color: AppColors.border,
                                //overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const RegisterScreen(),
                                  ),
                                );
                              },
                              child: AppText.small(
                                "Sign Up now",
                                color: AppColors.primary,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 39.h),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}