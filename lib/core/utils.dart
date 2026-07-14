import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:intl/intl.dart';

class AppUtils {
  /// Băm mật khẩu bằng SHA-256 để tăng tính bảo mật
  /// Theo đúng yêu cầu băm mật khẩu trước khi gửi đi
  static String hashPassword(String password) {
    var bytes = utf8.encode(password); // Chuyển text sang bytes
    var digest = sha256.convert(bytes); // Băm SHA-256
    return digest.toString(); // Trả về chuỗi Hex
  }

  /// Format giá tiền (VD: 3.53)
  static String formatPrice(double price) {
    final formatter = NumberFormat("0.00");
    return formatter.format(price);
  }
}
