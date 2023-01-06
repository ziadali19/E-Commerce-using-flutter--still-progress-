import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../controller/cubit/products_cubit.dart';

class PriceAndDiscount extends StatelessWidget {
  const PriceAndDiscount({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  final ProductsCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(cubit.productDetailsModel!.priceAfterDiscount!,
                style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black)),
            cubit.productDetailsModel!.priceAfterDiscount !=
                    cubit.productDetailsModel!.price
                ? Row(
                    children: [
                      Text(cubit.productDetailsModel!.price!,
                          style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                              decoration: TextDecoration.lineThrough,
                              color: Colors.black)),
                      SizedBox(
                        width: 2.w,
                      ),
                      Text(' ${cubit.productDetailsModel!.discount!} OFF',
                          style: TextStyle(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.black))
                    ],
                  )
                : SizedBox(
                    height: 0.h,
                  )
          ],
        ),
        const Spacer(),
      ],
    );
  }
}
