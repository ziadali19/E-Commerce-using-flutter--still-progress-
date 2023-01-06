import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../controller/cubit/products_cubit.dart';

Row userReviewsRating(ProductsCubit cubit) {
  return Row(
    children: [
      Container(
        padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 3.h),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: cubit.productDetailsModel!.rating! >= 4
                ? Colors.green
                : (cubit.productDetailsModel!.rating) >= 3
                    ? const Color.fromARGB(255, 74, 114, 76)
                    : Colors.grey),
        child: Row(
          children: [
            Text(cubit.productDetailsModel!.rating!.toString(),
                style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.white)),
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
      ),
      SizedBox(
        width: 3.w,
      ),
      Text(
        'based on ${cubit.productDetailsModel!.reviews.length} ratings',
        style: TextStyle(fontSize: 10.sp),
      ),
    ],
  );
}
