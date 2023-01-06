import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../controller/cubit/products_cubit.dart';

class OverView extends StatelessWidget {
  const OverView({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  final ProductsCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Overview',
          style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: Colors.black),
        ),
        Text(cubit.productDetailsModel!.description!),
      ],
    );
  }
}
