import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../controller/cubit/products_cubit.dart';

Row productNameAndRating(ProductsCubit cubit) {
  return Row(
    children: [
      Text(
        cubit.productDetailsModel!.productName!,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600),
      ),
      const Spacer(),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 3.h),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: cubit.productDetailsModel!.stock == 'available'
                ? Colors.green
                : const Color.fromARGB(255, 207, 32, 19)),
        child: Text(cubit.productDetailsModel!.stock!,
            style: TextStyle(
                fontSize: 11.sp,
                fontWeight: FontWeight.w400,
                color: Colors.white)),
      ),
      SizedBox(
        width: 5.w,
      ),
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
        '(${cubit.productDetailsModel!.reviews.length})',
        style: TextStyle(fontSize: 10.sp),
      ),
    ],
  );
}
