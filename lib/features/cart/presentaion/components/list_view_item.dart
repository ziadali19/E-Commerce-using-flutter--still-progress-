import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/utilis/constants.dart';

import '../../controller/cubit/cart_cubit.dart';

class ListViewItem extends StatelessWidget {
  const ListViewItem({super.key, required this.index});
  final int index;

  @override
  Widget build(BuildContext context) {
    // double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return BlocConsumer<CartCubit, CartState>(
      listener: (context, state) {},
      builder: (context, state) {
        CartCubit cubit = CartCubit.get(context);
        return Padding(
          padding: EdgeInsets.only(bottom: 20.h),
          child: Row(
            children: [
              Container(
                height: 90.h,
                width: 90.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(cubit
                            .cartModel!.data[index].product.productImage!))),
              ),
              SizedBox(
                width: 10.w,
              ),
              SizedBox(
                width: screenWidth * 0.3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cubit.cartModel!.data[index].product.productName!,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                          fontSize: 16.sp, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(cubit.cartModel!.data[index].totalPrice!,
                        style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.black)),
                  ],
                ),
              ),
              const Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                width: 120.w,
                height: 40.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: AppConstants.primaryColor),
                child: Row(children: [
                  GestureDetector(
                    onTap: () {
                      if (int.parse(cubit.cartModel!.data[index].amount!) ==
                          1) {
                        cubit.deleteItemFromCart(
                            token, cubit.cartModel!.data[index].itemId);
                      } else {
                        cubit.updateItemAmount(
                            token,
                            cubit.cartModel!.data[index].itemId,
                            int.parse(cubit.cartModel!.data[index].amount!) -
                                1);
                      }
                    },
                    child: SvgPicture.asset(
                      'assets/images/minus.svg',
                      color: Colors.white,
                      width: 20.w,
                      height: 20.h,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    cubit.cartModel!.data[index].amount!,
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w500),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      cubit.updateItemAmount(
                          token,
                          cubit.cartModel!.data[index].itemId,
                          int.parse(cubit.cartModel!.data[index].amount!) + 1);
                    },
                    child: SvgPicture.asset(
                      'assets/images/add.svg',
                      width: 20.w,
                      height: 20.h,
                      color: Colors.white,
                    ),
                  )
                ]),
              )
            ],
          ),
        );
      },
    );
  }
}
