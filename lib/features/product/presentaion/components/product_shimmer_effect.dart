import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

productShimmerEffect(double screenHeight, double screenWidth) {
  return Shimmer.fromColors(
    baseColor: Colors.grey[300]!,
    highlightColor: Colors.grey[100]!,
    child: Padding(
        padding: EdgeInsets.all(20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20.h,
            ),
            Container(
              height: screenHeight * 0.5,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: Colors.white),
            ),
            SizedBox(
              height: screenHeight * 0.02,
            ),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('31500',
                        style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.black)),
                    Row(
                      children: [
                        Text('59000',
                            style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                                decoration: TextDecoration.lineThrough,
                                color: Colors.black)),
                        SizedBox(
                          width: 2.w,
                        ),
                        Text(' 47% OFF',
                            style: TextStyle(
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.black))
                      ],
                    )
                  ],
                ),
                const Spacer(),
              ],
            ),
            SizedBox(
              height: screenHeight * 0.03,
            ),
            Text(
              'Overview',
              style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black),
            ),
            const Text(
                'Designed and measured to fit a 12″ to 14″ laptops and with a convenient front pocket for your charger cable and notebook. We can also make you a custom sized and coloured sleeve to fit your laptop/macbook or tablet. Get in touch for details.'),
          ],
        )),
  );
}
