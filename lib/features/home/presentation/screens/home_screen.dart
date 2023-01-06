import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utilis/constants.dart';
import '../../../login/presentaions/screens/login_screen.dart';
import '../../controller/cubit/home_cubit.dart';
import '../components/category_item.dart';
import '../components/home_shimmer_effect.dart';
import '../components/products_item.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is HomeGetActiveUserDataError) {
          AppConstants().showSnackBar(state.error, context, Colors.red);
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const LoginScreen()));
        }
        if (state is HomeGetProductsError) {
          AppConstants().showSnackBar(state.error, context, Colors.red);
        }
      },
      builder: (context, state) {
        HomeCubit cubit = HomeCubit.get(context);
        return RefreshIndicator(
          onRefresh: () {
            return cubit.getProducts(1);
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
              child: cubit.products.isNotEmpty && cubit.categories.isNotEmpty
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Explore',
                          style: TextStyle(
                              fontSize: 32.sp, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          'best Products for you',
                          style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w400,
                              color: Colors.black38),
                        ),
                        Container(
                          width: screenWidth * 0.8,
                          height: 1,
                          color: AppConstants.primaryColor,
                        ),
                        SizedBox(
                          height: screenHeight * 0.015,
                        ),
                        Text(
                          'Categories',
                          style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                        ),
                        SizedBox(
                          height: 17.h,
                        ),
                        CategoryItem(
                            screenHeight: screenHeight,
                            cubit: cubit,
                            screenWidth: screenWidth),
                        SizedBox(
                          height: screenHeight * 0.029,
                        ),
                        Text(
                          'Trending',
                          style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                        ),
                        SizedBox(
                          height: 17.h,
                        ),
                        productsItem(cubit, screenHeight),
                        Text(
                          'New arrival',
                          style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                        ),
                        SizedBox(
                          height: 17.h,
                        ),
                        productsItem(cubit, screenHeight),
                      ],
                    )
                  : shimmerEffect(screenHeight, screenWidth),
            ),
          ),
        );
      },
    );
  }
}
