// ignore_for_file: avoid_print

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

class AppConstants {
  static String? token;
  static GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();
  static GlobalKey<FormState> signInFormKey =
      GlobalKey<FormState>(debugLabel: 'login');
  static String baseUrl = 'http://jumia-clone.onlinewebshop.net/apis/';
  static String userRegisterEndPoint = 'customer/register';
  static String userLoginEndPoint = 'customer/login';
  static String getActiveUserData = 'active-user';
  static String getProducts = 'product';
  static String getCategories = 'category';
  static String forgetPassword = 'customer/forgot-password';
  static String resetPassword = 'customer/reset-password';
  static String paymobApiKey =
      "ZXlKMGVYQWlPaUpLVjFRaUxDSmhiR2NpT2lKSVV6VXhNaUo5LmV5SndjbTltYVd4bFgzQnJJam8yTnpnd01UQXNJbTVoYldVaU9pSXhOamMwTVRreE9EYzVMalV3TnpjeU1pSXNJbU5zWVhOeklqb2lUV1Z5WTJoaGJuUWlmUS5LaTdyMWpBZUtxbXU0UGl2d25aTEhHYlRIRWlZU0tLcWxmNjdLZkRaVk9uQTBLWkFQdzNUbVZtbWRSRl9QM0dVZ0Qtc2d1Y1RTTkRlb3RKazRPQ29Odw==";
  static String paymobFirstToken = '';
  static String paymobOrderId = '';
  static String paymobFinalToken = '';
  static num paymobIntegratioIdCard = 3317504;
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
  static List categoriesIcons = [
    'assets/images/1.svg',
    'assets/images/2.svg',
    'assets/images/perfume.svg',
    'assets/images/4.svg',
    'assets/images/5.svg',
    'assets/images/6.svg',
    'assets/images/7.svg',
    'assets/images/8.svg',
    'assets/images/9.svg',
    'assets/images/10.svg',
    'assets/images/11.svg',
    'assets/images/12.svg',
    'assets/images/13.svg',
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

bool? onBoarding;
String? token;
