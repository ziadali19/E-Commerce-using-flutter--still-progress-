import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

categoryDetailsShimmerEffect(double screenHeight, double screenWidth) {
  return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ListView(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                shimmerGridViewItem(),
                SizedBox(
                  height: screenHeight * 0.029,
                ),
                SizedBox(
                  height: screenHeight * 0.029,
                ),
                shimmerGridViewItem(),
                SizedBox(
                  height: screenHeight * 0.029,
                ),
                SizedBox(
                  height: screenHeight * 0.029,
                ),
                shimmerGridViewItem(),
                SizedBox(
                  height: screenHeight * 0.029,
                ),
                SizedBox(
                  height: screenHeight * 0.029,
                ),
                shimmerGridViewItem(),
                SizedBox(
                  height: screenHeight * 0.029,
                ),
                SizedBox(
                  height: screenHeight * 0.029,
                ),
                shimmerGridViewItem(),
              ],
            ),
          ),
        ],
      ));
}

SizedBox shimmerGridViewItem() {
  return SizedBox(
    height: 120.h,
    child: GridView.builder(
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10.w,
          crossAxisSpacing: 10.h,
          childAspectRatio: 1 / 2),
      itemCount: 5,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10.r)),
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
          child: const Center(
            child: Text(
              '',
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style:
                  TextStyle(fontWeight: FontWeight.w500, color: Colors.black),
            ),
          ),
        );
      },
    ),
  );
}
