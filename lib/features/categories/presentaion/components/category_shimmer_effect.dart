import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/utilis/constants.dart';

categoryShimmerEffect(double screenWidth, double screenHeight) {
  return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ListView.separated(
        itemCount: 15,
        separatorBuilder: (BuildContext context, int index) {
          return Container(
            height: 2.h,
            width: screenWidth,
            color: AppConstants.primaryColor,
          );
        },
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.all(8.0.h),
            child: SizedBox(
              height: screenHeight * 0.1,
              width: screenWidth,
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r)),
                elevation: 0,
                margin: EdgeInsets.all(5.sp),
                color: Colors.grey[300],
                child: Center(
                    child: Text(
                  '',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w500),
                )),
              ),
            ),
          );
        },
      ));
}
