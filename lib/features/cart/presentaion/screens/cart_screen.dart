import 'dart:ui';

import 'package:e_commerce/core/common/custom_elevated_button.dart';
import 'package:e_commerce/features/cart/controller/cubit/cart_cubit.dart';
import 'package:e_commerce/features/cart/presentaion/components/cart_shimmer_effect.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/utilis/constants.dart';
import '../../../../main.dart';
import '../components/list_view_item.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return BlocConsumer<CartCubit, CartState>(listener: (context, state) {
      if (state is GetUserCartError) {
        AppConstants().showSnackBar(state.error, context, Colors.red);
        CartCubit.get(context).getUserCart(token);
      }
      if (state is UpdateItemAmountError) {
        AppConstants().showSnackBar(state.error, context, Colors.red);
        CartCubit.get(context).getUserCart(token);
      }
      if (state is DeleteItemFromCartError) {
        AppConstants().showSnackBar(state.error, context, Colors.red);
        CartCubit.get(context).getUserCart(token);
      }
    }, builder: (context, state) {
      CartCubit cubit = CartCubit.get(context);
      if (state is GetUserCartLoading ||
          state is UpdateItemAmountLoading ||
          state is DeleteItemFromCartLoading) {
        return RefreshIndicator(
          child: cartShimmerEffect(screenWidth, screenHeight),
          onRefresh: () {
            return cubit.getUserCart(token);
          },
        );
      } else {
        return cubit.cartModel != null && cubit.cartModel!.totalItems != 0
            ? Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                child: ListView(
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: cubit.cartModel!.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListViewItem(
                          index: index,
                        );
                      },
                    ),
                    const Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Order Summary',
                          style: TextStyle(
                              fontSize: 16.sp, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        Row(
                          children: [
                            Text(
                              'Subtotal',
                              style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xff828A89)),
                            ),
                            const Spacer(),
                            Text(
                              cubit.cartModel!.overallPrice.toString(),
                              style: const TextStyle(
                                  color: AppConstants.primaryColor,
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        Row(
                          children: [
                            Text(
                              'Shipping cost',
                              style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xff828A89)),
                            ),
                            const Spacer(),
                            const Text(
                              '50 EGP',
                              style: TextStyle(
                                color: AppConstants.primaryColor,
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        Row(
                          children: [
                            Text(
                              'Total payment',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              '${RegExp(r"-?(?:\d*\.)?\d+(?:[eE][+-]?\d+)?").allMatches(cubit.cartModel!.overallPrice!).map((m) => double.parse(m[0]!)).toList()[0] + 50.0} EGP',
                              style: const TextStyle(
                                  color: AppConstants.primaryColor,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomElevatedButton(
                              onPressed: () {},
                              text: 'Checkout',
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              )
            : cubit.cartModel != null && cubit.cartModel!.totalItems == 0
                ? Center(
                    child: Text(
                      'Your cart is empty',
                      style: TextStyle(fontSize: 20.sp),
                    ),
                  )
                : Text(
                    'Network error!!!',
                    style: TextStyle(fontSize: 20.sp),
                  );
      }
    });
  }
}
