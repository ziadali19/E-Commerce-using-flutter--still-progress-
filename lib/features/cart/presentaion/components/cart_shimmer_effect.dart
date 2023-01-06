import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/utilis/constants.dart';

cartShimmerEffect(double screenWidth, double screenHeight) {
  return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            ListView.builder(
              shrinkWrap: true,
              itemCount: 4,
              itemBuilder: (BuildContext context, int index) {
                return Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 15.h),
                      width: screenWidth * 0.4,
                      height: 100.h,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.r)),
                    ),
                    const Spacer(),
                    Container(
                      margin: EdgeInsets.only(bottom: 15.h),
                      width: screenWidth * 0.3,
                      height: 50.h,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.r)),
                    ),
                  ],
                );
              },
            ),
            const Spacer(),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                'Order Summary',
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
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
                  const Text(
                    '2500',
                    style: TextStyle(
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
              Row(children: [
                Text(
                  'Total payment',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                )
              ])
            ])
          ])));
}
