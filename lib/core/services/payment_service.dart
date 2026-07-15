import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../constants/api_keys.dart';

class PaymentService extends GetxService {
  
  /// Khởi tạo Payment Sheet
  Future<void> initPaymentSheet(double amount, String currency) async {
    try {
      // 1. Tạo Payment Intent từ "backend" (Ở đây mình giả lập gọi API Stripe trực tiếp để demo sandbox)
      // LƯU Ý: Trong thực tế, bước này PHẢI thực hiện ở Server để bảo mật Secret Key.
      final paymentIntent = await createPaymentIntent(amount, currency);

      // 2. Cấu hình Payment Sheet
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntent['client_secret'],
          merchantDisplayName: 'CoBrew Coffee Shop',
          style: ThemeMode.light,
        ),
      );
    } catch (e) {
      print("--- ERROR initPaymentSheet: $e");
      rethrow;
    }
  }

  /// Hiển thị Payment Sheet để người dùng nhập thẻ
  Future<void> presentPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet();
    } catch (e) {
      if (e is StripeException) {
        print("--- STRIPE ERROR: ${e.error.localizedMessage}");
        throw e.error.localizedMessage ?? "Payment failed";
      } else {
        print("--- UNEXPECTED ERROR: $e");
        throw "An unexpected error occurred";
      }
    }
  }

  /// Giả lập Backend gọi Stripe API để tạo PaymentIntent
  /// CẢNH BÁO: Không nên để Secret Key trong app như thế này ở bản Production.
  Future<Map<String, dynamic>> createPaymentIntent(double amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': (amount * 100).toInt().toString(), // Stripe dùng đơn vị cent
        'currency': currency,
        'payment_method_types[]': 'card',
      };

      final response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer ${ApiKeys.stripeSecretKey}',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: body,
      );

      return jsonDecode(response.body);
    } catch (e) {
      print("--- ERROR createPaymentIntent: $e");
      rethrow;
    }
  }
}
