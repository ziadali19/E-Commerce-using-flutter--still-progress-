import 'package:e_commerce/features/product/controller/cubit/products_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utilis/constants.dart';

class ImageIndicator extends StatelessWidget {
  const ImageIndicator({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  final ProductsCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ...List.generate(cubit.productDetailsModel!.gallery.length, (index) {
          return Container(
            margin: EdgeInsets.only(right: 5.w),
            height: 10.h,
            width: 10.w,
            decoration: BoxDecoration(
                border: Border.all(),
                shape: BoxShape.circle,
                color: cubit.indicatorIndex == index
                    ? AppConstants.primaryColor
                    : Colors.white),
          );
        })
      ],
    );
  }
}
