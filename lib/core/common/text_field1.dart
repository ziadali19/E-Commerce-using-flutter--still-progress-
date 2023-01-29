import 'package:e_commerce/core/utilis/constants.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../features/register/controller/cubit/register_cubit.dart';

class CustomTextFieldR extends StatelessWidget {
  final TextEditingController controller;
  final TextEditingController? passController;
  final TextEditingController? passConfirmcontroller;
  final TextInputType textInputType;
  final String hintText;
  final RegisterCubit? cubit;
  final String? assetName;
  const CustomTextFieldR(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.textInputType,
      this.assetName,
      this.cubit,
      this.passController,
      this.passConfirmcontroller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: AppConstants.primaryColor,
      cursorHeight: 18,
      keyboardType: textInputType,
      validator: (value) {
        if (hintText == 'Name') {
          if (value == null || value == '') {
            return 'Name is invaild';
          } else {
            return null;
          }
        } else if (hintText == 'Email') {
          if (value == null || !value.contains('@')) {
            return 'Email is invalid';
          } else {
            return null;
          }
        } else if (hintText == 'Phone') {
          if (value == null || value == '') {
            return 'Phone is invalid';
          } else {
            return null;
          }
        } else if (hintText == 'Password') {
          if (value == null || value.length < 8) {
            return 'Password is invalid';
          } else {
            return null;
          }
        } else {
          if (value == null ||
              value.length < 8 ||
              passConfirmcontroller!.text != passController!.text) {
            return 'Password is invalid';
          } else {
            return null;
          }
        }
      },
      style: const TextStyle(height: 1),
      controller: controller,
      obscureText: hintText == 'Password' || hintText == 'Confirm Password'
          ? (cubit!.isVisible ? false : true)
          : false,
      decoration: InputDecoration(
          icon: SvgPicture.asset(
            height: 30.h,
            width: 30.w,
            assetName!,
            color: AppConstants.primaryColor,
          ),
          suffixIcon: hintText == 'Password' || hintText == 'Confirm Password'
              ? IconButton(
                  color: AppConstants.primaryColor,
                  icon: cubit!.isVisible
                      ? SvgPicture.asset(
                          'assets/images/hide 1.svg',
                          color: AppConstants.primaryColor,
                        )
                      : SvgPicture.asset('assets/images/eye 1.svg',
                          color: AppConstants.primaryColor),
                  onPressed: () {
                    cubit!.changeVisibilty();
                  },
                )
              : const Text(''),
          hintText: hintText,
          hintStyle: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              color: const Color(0xff230A06).withOpacity(0.7)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(color: AppConstants.primaryColor)),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(color: AppConstants.primaryColor)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(
                  color: AppConstants.primaryColor, width: 1.5)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(color: AppConstants.primaryColor))),
    );
  }
}
