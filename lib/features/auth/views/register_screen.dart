import 'package:coffee/core/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/constants/constants.dart';
import '../../../core/widgets/auth_header.dart';
import '../../../core/widgets/auth_input.dart';
import '../../../core/widgets/primary_button.dart';
import '../controllers/auth_controller.dart';
import '../repository/auth_repository.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  // Khởi tạo controller và repository
  final AuthController authController = Get.put(
    AuthController(repository: AuthRepository()),
  );

  // Các controller quản lý nhập liệu
  final TextEditingController emailController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController displayNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    userNameController.dispose();
    displayNameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void _handleSignUp() async {
    final email = emailController.text.trim();
    final userName = userNameController.text.trim();
    final displayName = displayNameController.text.trim();
    final password = passwordController.text;
    final confirmPassword = confirmPasswordController.text;

    // Validate cơ bản
    if (email.isEmpty || userName.isEmpty || displayName.isEmpty || password.isEmpty) {
      Get.snackbar("Lỗi", "Vui lòng điền đầy đủ thông tin");
      return;
    }

    if (password != confirmPassword) {
      Get.snackbar("Lỗi", "Mật khẩu xác nhận không khớp");
      return;
    }

    // Bắt đầu luồng đăng ký (Kiểm tra trùng + Gửi OTP)
    await authController.startSignUp(
      email: email,
      password: password,
      userName: userName,
      displayName: displayName,
    );

    // Nếu gửi OTP thành công (không có lỗi tung ra), chuyển sang màn hình Verify
    if (!authController.isLoading.value) {
      Get.toNamed(
        Routes.VERIFY_OTP,
        arguments: {
          'email': email,
          'userName': userName,
          'displayName': displayName,
          'password': password,
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: AppSizes.screenPadding,
          child: Column(
            children: [
              const AuthHeader(
                title: "Create Account",
                subtitle: "Join our specialty community today.",
              ),
              SizedBox(height: 30.h),
              AuthInput(
                label: "Display Name",
                hintText: "Your full name",
                controller: displayNameController,
              ),
              SizedBox(height: 10.h),
              AuthInput(
                label: "Username",
                hintText: "Choose a unique username",
                controller: userNameController,
              ),
              SizedBox(height: 10.h),
              AuthInput(
                label: "Email Address",
                hintText: "yourname@domain.com",
                inputType: TextInputType.emailAddress,
                controller: emailController,
              ),
              SizedBox(height: 10.h),
              AuthInput(
                label: "Password",
                hintText: "Create a password",
                isPassword: true,
                controller: passwordController,
              ),
              SizedBox(height: 10.h),
              AuthInput(
                label: "Confirm password",
                hintText: "Confirm a password",
                isPassword: true,
                controller: confirmPasswordController,
              ),
              SizedBox(height: 30.h),
              
              // Nút Đăng ký với trạng thái Loading
              Obx(() => PrimaryButton(
                buttonContext: authController.isLoading.value ? 'Sending OTP...' : 'Sign Up',
                onPressed: authController.isLoading.value ? null : _handleSignUp,
              )),
              
              SizedBox(height: 26.h),
              
              // Sign up with Google (Để trống logic theo yêu cầu)
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
                      AppText.medium("Sign Up with Google"),
                    ],
                  ),
                ),
              ),
              
              SizedBox(height: 26.h),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppText.small(
                    "Have an account? ",
                    color: AppColors.border,
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const AppText.small(
                      "Sign In now",
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
    );
  }
}
