import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

class AppConstants {
  static String? token;
  static GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();
  static GlobalKey<FormState> signInFormKey = GlobalKey<FormState>();
  static String baseUrl = 'https://jumia-samir-hussein.vercel.app/apis/';
  static String userRegisterEndPoint = 'customer/register';
  static String userLoginEndPoint = 'customer/login';
  static String getActiveUserData = 'active-user';
  static String getProducts = 'product';
  static String getCategories = 'category';
  static String forgetPassword = 'customer/forgot-password';
  static String resetPassword = 'customer/reset-password';
  static const primaryColor = Color(0xffF67952);
  static const backgroundColor = Color(0xffFBFBFD);
  static const blackColor = Color(0xff000000);
  static const List images = [
    'assets/images/onboard1.svg',
    'assets/images/onboard2.svg',
    'assets/images/onboard3.svg'
  ];
  static const List titles = [
    'Choose Product',
    'Make Payment',
    'Get Your Order'
  ];
  static const List body = [
    'A product is the item offered for sale. A product can be a service or an item. It can be physical or in virtual or cyber form',
    'Payment is the transfer of money services in exchange product or Payments typically made terms agreed ',
    'Business or commerce an order is a stated intention either spoken to engage in a commercial transaction specific CatgetCategories '
  ];
  showSnackBar(String? msg, BuildContext context, Color? clr) {
    showToast(
      msg,
      context: context,
      backgroundColor: clr,
      animation: StyledToastAnimation.slideFromTopFade,
      reverseAnimation: StyledToastAnimation.fade,
      position:
          const StyledToastPosition(align: Alignment.bottomCenter, offset: 70),
      animDuration: const Duration(seconds: 1),
      duration: const Duration(seconds: 4),
      curve: Curves.bounceOut,
      reverseCurve: Curves.linear,
    );
  }
}

class MyBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    print('onCreate -- ${bloc.runtimeType}');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print('onChange -- ${bloc.runtimeType}, $change');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print('onError -- ${bloc.runtimeType}, $error');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    print('onClose -- ${bloc.runtimeType}');
  }
}
