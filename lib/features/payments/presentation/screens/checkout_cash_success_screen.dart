import 'package:e_commerce/core/common/custom_elevated_button.dart';
import 'package:e_commerce/core/utilis/constants.dart';
import 'package:e_commerce/features/cart/controller/cubit/cart_cubit.dart';
import 'package:e_commerce/features/home/presentation/layouts/home_layout_screen.dart';
import 'package:e_commerce/features/settings/controller/cubit/orders_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../settings/presentation/screens/orders_screen.dart';

class CheckoutCashSuccessScreen extends StatelessWidget {
  const CheckoutCashSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  SvgPicture.asset('assets/images/circle.svg'),
                  SvgPicture.asset('assets/images/success.svg')
                ],
              ),
              SizedBox(
                height: 83.h,
              ),
              Text(
                'Congratulation!!!',
                style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w500,
                    color: AppConstants.primaryColor),
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                'Your order been place successfully! you can track the order in the orders section',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.black.withOpacity(0.7)),
              ),
              SizedBox(
                height: 30.h,
              ),
              CustomElevatedButton(
                onPressed: () {
                  OrdersCubit.get(context).getUserOrders();
                  CartCubit.get(context).getUserCart(token!);
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const OrdersScreen(),
                  ));
                },
                text: 'Track Your Order',
              ),
              SizedBox(
                height: 20.h,
              ),
              TextButton(
                  onPressed: () {
                    CartCubit.get(context).getUserCart(token!);

                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const HomeLayoutScreen(),
                    ));
                  },
                  child: Text(
                    'Back to Home',
                    style: TextStyle(
                        color: AppConstants.primaryColor,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
