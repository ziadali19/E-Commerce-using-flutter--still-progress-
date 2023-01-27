import 'package:e_commerce/core/utilis/constants.dart';
import 'package:e_commerce/features/categories/presentaion/components/category_details_shimmer_effect.dart';
import 'package:e_commerce/features/categories/presentaion/components/custom_app_bar.dart';
import 'package:e_commerce/features/settings/controller/cubit/orders_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrdersCubit, OrdersState>(
      listener: (context, state) {
        if (state is GetOrdersError) {
          AppConstants().showSnackBar(state.errorMsg, context, Colors.red);
        }
      },
      builder: (context, state) {
        double screenHeight = MediaQuery.of(context).size.height;
        double screenWidth = MediaQuery.of(context).size.width;
        OrdersCubit cubit = OrdersCubit.get(context);
        return Scaffold(
          appBar: customAppBar(context, 'Orders'),
          body: Padding(
            padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
            child: state is GetOrdersLoading
                ? categoryDetailsShimmerEffect(screenHeight, screenWidth)
                : state is GetOrdersSuccess && cubit.ordersList.isEmpty
                    ? Center(
                        child: Text(
                        'No Orders is Added Yet. Go and make your first order',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20.sp, fontWeight: FontWeight.w400),
                      ))
                    : ListView.separated(
                        itemCount: cubit.ordersList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return SizedBox(
                            width: double.infinity,
                            child: Card(
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.r)),
                              color: Colors.grey[200],
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 7.h, horizontal: 7.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        'Delivery status: ${cubit.ordersList[index].delivery}',
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.w500)),
                                    SizedBox(
                                      height: 5.h,
                                    ),
                                    Text(
                                        'Total price: ${cubit.ordersList[index].totalPrice}',
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.w500)),
                                    SizedBox(
                                      height: 5.h,
                                    ),
                                    Text(cubit.ordersList[index].createdAt!,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 13.sp,
                                            fontWeight: FontWeight.w400)),
                                    SizedBox(
                                      height: 5.h,
                                    ),
                                    Text(
                                        'Order ID: ${cubit.ordersList[index].id}',
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 13.sp,
                                            fontWeight: FontWeight.w400)),
                                    SizedBox(
                                      height: 5.h,
                                    ),
                                    Text(
                                        'Payment type: ${cubit.ordersList[index].paymentType}',
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 13.sp,
                                            fontWeight: FontWeight.w400))
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return SizedBox(
                            height: 20.h,
                          );
                        },
                      ),
          ),
        );
      },
    );
  }
}
