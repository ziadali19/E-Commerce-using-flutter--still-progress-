import 'package:e_commerce/core/utilis/constants.dart';
import 'package:e_commerce/features/search/controller/cubit/search_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../features/login/controller/cubit/login_cubit.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType textInputType;
  final String hintText;
  LoginCubit? cubit;
  SearchCubit? searchCubit;
  String? assetName;
  CustomTextField(
      {super.key,
      this.searchCubit,
      required this.controller,
      required this.hintText,
      required this.textInputType,
      this.assetName,
      this.cubit});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: AppConstants.primaryColor,
      cursorHeight: 18,
      keyboardType: textInputType,
      onFieldSubmitted: hintText == 'What are you looking for?'
          ? (value) {
              searchCubit!.searchProducts(searchCubit!.searchController.text,
                  searchCubit!.searchPageNumber);
            }
          : (value) {},
      validator: (value) {
        if (hintText == 'Name') {
          if (value == null || value == '') {
            return 'Name is invaild';
          } else {
            return null;
          }
        } else if (hintText == 'Email' || hintText == 'Enter your E-mail') {
          if (value == null || !value.contains('@')) {
            return 'Email is invalid';
          } else {
            return null;
          }
        } else {
          if (value == null || value.length < 8) {
            return 'Password is invalid';
          } else {
            return null;
          }
        }
      },
      controller: controller,
      obscureText:
          hintText == 'Password' ? (cubit!.isVisible ? false : true) : false,
      decoration: InputDecoration(
          icon: SvgPicture.asset(
            height: 30.h,
            width: 30.w,
            assetName!,
          ),
          suffixIcon: hintText == 'Password'
              ? IconButton(
                  color: AppConstants.primaryColor,
                  icon: cubit!.isVisible
                      ? SvgPicture.asset(
                          'assets/images/hide 1.svg',
                          color: AppConstants.primaryColor,
                        )
                      : SvgPicture.asset(
                          'assets/images/eye 1.svg',
                          color: AppConstants.primaryColor,
                        ),
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
