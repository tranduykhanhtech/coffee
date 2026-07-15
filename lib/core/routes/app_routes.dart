part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const DASHBOARD = _Paths.DASHBOARD;
  static const LOGIN = _Paths.LOGIN; 
  static const HOME = _Paths.HOME;
  static const ITEM_DETAIL = _Paths.ITEM_DETAIL;
  static const CART = _Paths.CART;
  static const ORDER = _Paths.ORDER;
  static const ORDER_HISTORY = _Paths.ORDER_HISTORY;
  static const NOTIFICATION = _Paths.NOTIFICATION;
  static const FAVORITE = _Paths.FAVORITE;
  static const PAYMENT_METHOD = _Paths.PAYMENT_METHOD;
  static const PROFILE = _Paths.PROFILE;
  static const VERIFY_OTP = _Paths.VERIFY_OTP;
}

abstract class _Paths {
  _Paths._();
  static const DASHBOARD = '/dashboard';
  static const LOGIN = '/login'; 
  static const HOME = '/home';
  static const ITEM_DETAIL = '/item-detail';
  static const CART = '/cart';
  static const ORDER = '/order';
  static const ORDER_HISTORY = '/order-history';
  static const NOTIFICATION = '/notification';
  static const FAVORITE = '/favorite';
  static const PAYMENT_METHOD = '/payment-method';
  static const PROFILE = '/profile';
  static const VERIFY_OTP = '/verify-otp';
}
