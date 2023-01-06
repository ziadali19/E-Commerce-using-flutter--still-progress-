import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/utilis/constants.dart';

shimmerEffect(double screenHeight, double screenWidth) {
  return Shimmer.fromColors(
    baseColor: Colors.grey[300]!,
    highlightColor: Colors.grey[100]!,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Explore',
          style: TextStyle(fontSize: 32.sp, fontWeight: FontWeight.w500),
        ),
        Text(
          'best Products for you',
          style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w400,
              color: Colors.black38),
        ),
        Container(
          width: screenWidth * 0.8,
          height: 1,
          color: AppConstants.primaryColor,
        ),
        SizedBox(
          height: screenHeight * 0.015,
        ),
        Text(
          'Categories',
          style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w500,
              color: Colors.black),
        ),
        SizedBox(
          height: 17.h,
        ),
        SizedBox(
            height: screenHeight * 0.2,
            child: ListView.separated(
              itemCount: 6,
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  width: screenWidth * 0.25,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.r)),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(
                  width: 10.w,
                );
              },
            )),
        SizedBox(
          height: screenHeight * 0.029,
        ),
        Text(
          'Trending',
          style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w500,
              color: Colors.black),
        ),
        SizedBox(
          height: 17.h,
        ),
        SizedBox(
            height: screenHeight * 0.2,
            child: ListView.separated(
              itemCount: 6,
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  width: screenWidth * 0.25,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.r)),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(
                  width: 10.w,
                );
              },
            )),
        Text(
          'New arrival',
          style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w500,
              color: Colors.black),
        ),
        SizedBox(
          height: 17.h,
        ),
        SizedBox(
            height: screenHeight * 0.2,
            child: ListView.separated(
              itemCount: 6,
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  width: screenWidth * 0.25,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.r)),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(
                  width: 10.w,
                );
              },
            )),
      ],
    ),
  );
}
