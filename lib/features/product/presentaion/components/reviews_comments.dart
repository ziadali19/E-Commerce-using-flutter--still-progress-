import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../controller/cubit/products_cubit.dart';

Column reviewsComments(ProductsCubit cubit, int index) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        cubit.productDetailsModel!.reviews[index].customer.customerName!,
        style: const TextStyle(fontWeight: FontWeight.w500),
      ),
      Row(
        children: [
          Text(cubit.productDetailsModel!.reviews[index].rating.toString(),
              style: TextStyle(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.black)),
          Container(
            transform: Matrix4.translationValues(0, -1.7, 0),
            child: const Icon(
              Icons.star_rounded,
              size: 15,
              color: Color.fromARGB(255, 249, 216, 2),
            ),
          ),
        ],
      ),
      SizedBox(
        height: 5.h,
      ),
      cubit.productDetailsModel!.reviews[index].comment != null
          ? Text(cubit.productDetailsModel!.reviews[index].comment!)
          : const SizedBox(),
    ],
  );
}
