import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

favoriteShimmerEffect(double screenHeight, double screenWidth) {
  return Shimmer.fromColors(
    baseColor: Colors.grey[300]!,
    highlightColor: Colors.grey[100]!,
    child: Padding(
      padding: EdgeInsets.all(20.h),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisSpacing: 10.h,
            crossAxisSpacing: 10.w,
            crossAxisCount: 2,
            mainAxisExtent: 250.h),
        itemCount: 20,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            height: 250.h,
            width: 150.w,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r), color: Colors.white),
          );
        },
      ),
    ),
  );
}
