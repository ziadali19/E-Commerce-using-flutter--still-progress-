import 'package:e_commerce/core/common/custom_elevated_button.dart';
import 'package:e_commerce/features/cart/controller/cubit/cart_cubit.dart';
import 'package:e_commerce/features/categories/presentaion/components/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/utilis/constants.dart';
import '../../../home/controller/cubit/home_cubit.dart';
import '../../../settings/presentation/screens/add_address_screen.dart';
import '../../controller/cubit/payments_cubit.dart';
import 'checkout_cash_success_screen.dart';
import 'checkout_visa_success_screen.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PaymentsCubit, PaymentsState>(
      listener: (context, state) {
        if (state is MakeCheckoutError) {
          AppConstants().showSnackBar(state.errorMsg, context, Colors.red);
        }
        if (state is GetFinalTokenError) {
          AppConstants().showSnackBar(state.errorMsg, context, Colors.red);
        }
        if (state is GetFirstTokenError) {
          AppConstants().showSnackBar(state.errorMsg, context, Colors.red);
        }
        if (state is GetOrderIdTokenError) {
          AppConstants().showSnackBar(state.errorMsg, context, Colors.red);
        }
        if (state is MakeCheckoutSuccess &&
            PaymentsCubit.get(context).groupVal == 1) {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => const CheckoutCashSuccessScreen()));
        }
        if (state is GetFinalTokenSuccess &&
            PaymentsCubit.get(context).groupVal == 2) {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => const CheckoutVisaSuccessScreen()));
        }
      },
      builder: (context, state) {
        PaymentsCubit cubit = PaymentsCubit.get(context);
        return Scaffold(
          appBar: customAppBar(context, 'Checkout'),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            child: ListView(
              children: [
                Text(
                  'Delivery address',
                  style:
                      TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 15.h,
                ),
                SizedBox(
                  width: double.infinity,
                  child: Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.r)),
                    color: Colors.grey[200],
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 7.h, horizontal: 7.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  CartCubit.get(context).addressModel!.country!,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w500)),
                              SizedBox(
                                height: 5.h,
                              ),
                              Text(CartCubit.get(context).addressModel!.state!,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.w400)),
                              SizedBox(
                                height: 5.h,
                              ),
                              Text(CartCubit.get(context).addressModel!.city!,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.w400)),
                              SizedBox(
                                height: 5.h,
                              ),
                              Text(
                                  CartCubit.get(context)
                                      .addressModel!
                                      .addressDetails!,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.w400)),
                              SizedBox(
                                height: 5.h,
                              ),
                              Text(
                                  HomeCubit.get(context).userModel!.data.phone!,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.w400))
                            ],
                          ),
                          const Spacer(),
                          InkWell(
                            child: SvgPicture.asset('assets/images/edit.svg'),
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const AddAddressScreen(),
                              ));
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 36.h,
                ),
                Text(
                  'Billing information',
                  style:
                      TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 15.h,
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
                      CartCubit.get(context).cartModel!.overallPrice.toString(),
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
                  height: 8.h,
                ),
                Row(
                  children: [
                    Text(
                      'Total payment',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      '${RegExp(r"-?(?:\d*\.)?\d+(?:[eE][+-]?\d+)?").allMatches(CartCubit.get(context).cartModel!.overallPrice!).map((m) => double.parse(m[0]!)).toList()[0] + 50.0} EGP',
                      style: const TextStyle(
                          color: AppConstants.primaryColor,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                SizedBox(
                  height: 36.h,
                ),
                Text(
                  'Payment Method',
                  style:
                      TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 15.h,
                ),
                state is MakeCheckoutLoading ||
                        state is GetFirstTokenLoading ||
                        state is GetFinalTokenLoading ||
                        state is GetFirstTokenSuccess ||
                        state is MakeCheckoutSuccess ||
                        state is GetOrderIdTokenLoading ||
                        state is GetOrderIdTokenSuccess
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RadioListTile(
                            secondary: Image.asset(
                              'assets/images/cash.png',
                              width: 35.w,
                              height: 35.h,
                            ),
                            title: Text('Cash on Delivery',
                                style: TextStyle(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w500)),
                            activeColor: AppConstants.primaryColor,
                            value: cubit.cash,
                            groupValue: cubit.groupVal,
                            onChanged: (value) {
                              cubit.changeGroupVal(value);
                            },
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          RadioListTile(
                            secondary:
                                SvgPicture.asset('assets/images/visa.svg'),
                            title: Text('Debit/Credit Card',
                                style: TextStyle(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w500)),
                            activeColor: AppConstants.primaryColor,
                            value: cubit.visa,
                            groupValue: cubit.groupVal,
                            onChanged: (value) {
                              cubit.changeGroupVal(value);
                            },
                          ),
                          SizedBox(
                            height: 36.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomElevatedButton(
                                onPressed: () async {
                                  if (cubit.groupVal == 1) {
                                    cubit.makeCheckout(
                                        'cash',
                                        CartCubit.get(context)
                                            .addressModel!
                                            .country,
                                        CartCubit.get(context)
                                            .addressModel!
                                            .state!,
                                        CartCubit.get(context)
                                            .addressModel!
                                            .city,
                                        CartCubit.get(context)
                                            .addressModel!
                                            .addressDetails,
                                        HomeCubit.get(context)
                                            .userModel!
                                            .data
                                            .phone);
                                  } else {
                                    await cubit.makeCheckout(
                                        'visa',
                                        CartCubit.get(context)
                                            .addressModel!
                                            .country,
                                        CartCubit.get(context)
                                            .addressModel!
                                            .state!,
                                        CartCubit.get(context)
                                            .addressModel!
                                            .city,
                                        CartCubit.get(context)
                                            .addressModel!
                                            .addressDetails,
                                        HomeCubit.get(context)
                                            .userModel!
                                            .data
                                            .phone);
                                    if (cubit.orderSuccessModel != null) {
                                      await cubit.paymobGetFirstToken();
                                      await cubit.paymobGetOrderId(
                                          (cubit.orderSuccessModel!
                                                      .totalPrice! *
                                                  100)
                                              .toString(),
                                          cubit.orderSuccessModel!.orderId);
                                      await cubit.paymobGetFinalToken(
                                          HomeCubit.get(context)
                                              .userModel!
                                              .data
                                              .name,
                                          HomeCubit.get(context)
                                              .userModel!
                                              .data
                                              .name,
                                          HomeCubit.get(context)
                                              .userModel!
                                              .data
                                              .email,
                                          HomeCubit.get(context)
                                              .userModel!
                                              .data
                                              .phone,
                                          (cubit.orderSuccessModel!
                                                      .totalPrice! *
                                                  100)
                                              .toString());
                                    }
                                  }
                                },
                                text: cubit.groupVal == 1
                                    ? 'Place Order'
                                    : 'Payment',
                              ),
                            ],
                          ),
                        ],
                      )
              ],
            ),
          ),
        );
      },
    );
  }
}
