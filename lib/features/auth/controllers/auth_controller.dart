import 'dart:async'; // Thêm import cho Timer
import 'package:coffee/core/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../repository/auth_repository.dart';

class AuthController extends GetxController {
  final AuthRepository repository;
  AuthController({required this.repository});

  var isLoading = false.obs;

  // --- Logic Resend OTP ---
  var countdown = 0.obs; // Đếm ngược số giây
  Timer? _timer;

  void startCountdown() {
    countdown.value = 36; // Cập nhật lên 36 giây theo ý ô nhé
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (countdown.value > 0) {
        countdown.value--;
      } else {
        _timer?.cancel();
      }
    });
  }

  Future<void> resendOTP(String email) async {
    try {
      if (countdown.value > 0) return; // Đang trong thời gian chờ thì không cho gửi

      isLoading.value = true;
      await repository.resendOTP(email: email);
      
      startCountdown(); // Bắt đầu đếm ngược sau khi gửi thành công
      Get.snackbar("Thành công", "Mã xác thực mới đã được gửi");
    } catch (e) {
      Get.snackbar("Lỗi", "Không thể gửi lại mã: ${e.toString()}");
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    _timer?.cancel(); // Hủy timer khi controller bị xóa
    super.onClose();
  }
  // -------------------------

  /// Luồng Đăng ký: Kiểm tra trùng -> Gửi OTP
  Future<void> startSignUp({
    required String email,
    required String password,
    required String userName,
    required String displayName,
  }) async {
    try {
      isLoading.value = true;

      // Bước 1: Kiểm tra trùng lặp
      final isExists = await repository.checkUserExists(email, userName);
      if (isExists) {
        Get.snackbar("Lỗi", "Email hoặc Tên đăng nhập đã tồn tại");
        return;
      }

      // Bước 2: Gửi OTP
      await repository.signUpWithOTP(
        email: email,
        password: password,
        userName: userName,
        displayName: displayName,
      );

      // Mở màn hình OTP và truyền data sang để verify
      Get.toNamed(Routes.VERIFY_OTP, arguments: {
        'email': email,
        'userName': userName,
        'displayName': displayName,
        'password': password,
      });
      
      Get.snackbar("Thành công", "Vui lòng kiểm tra email để lấy mã xác thực");
      
    } catch (e) {
      Get.snackbar("Lỗi đăng ký", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  /// Luồng Xác thực: Validate OTP -> Tạo User
  Future<void> completeSignUp({
    required String email,
    required String token,
    required String userName,
    required String displayName,
  }) async {
    try {
      isLoading.value = true;

      // Bước 3: Xác thực OTP
      final response = await repository.verifyOTP(email: email, token: token);

      if (response.user != null) {
        // Bước 4: Tạo user thủ công sau khi verify thành công (Rollback về đoạn này)
        try {
          await repository.createPublicUser(
            id: response.user!.id,
            email: email,
            userName: userName,
            displayName: displayName,
          );
        } catch (dbError) {
          // Nếu lỗi insert bảng public thì log ra nhưng vẫn cho user vào app (vì acc Auth đã tạo xong)
          print("Lỗi tạo user public: $dbError");
        }
        
        Get.snackbar("Thành công", "Tài khoản của bạn đã được kích hoạt");
        
        // Chuyển thẳng về Dashboard
        Get.offAllNamed(Routes.DASHBOARD);
      }
    } catch (e) {
      Get.snackbar("Lỗi xác thực", "Mã OTP không chính xác hoặc đã hết hạn");
    } finally {
      isLoading.value = false;
    }
  }

  /// Luồng Đăng nhập: Kiểm tra credentials -> Lấy JWT -> Chuyển màn hình
  Future<void> login({
    required String email,
    required String password,
  }) async {
    try {
      isLoading.value = true;

      final response = await repository.signIn(email: email, password: password);

      if (response.user != null) {
        // Đăng nhập thành công, hiện snackbar trước
        Get.snackbar("Thành công", "Chào mừng bạn quay trở lại!");
        
        // Chuyển hướng tường minh về Dashboard
        Get.offAllNamed(Routes.DASHBOARD); 
      }
    } on AuthException catch (e) {
      Get.snackbar("Lỗi đăng nhập", e.message); 
    } catch (e) {
      // In lỗi thật ra console để debug nếu có "Lỗi hệ thống"
      print("Error during login navigation: $e");
      Get.snackbar("Lỗi hệ thống", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
