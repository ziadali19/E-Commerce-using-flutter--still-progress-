import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/common/custom_elevated_button.dart';
import '../../../../core/utilis/constants.dart';
import '../../../home/controller/cubit/home_layout_cubit.dart';
import '../../../home/presentation/layouts/home_layout_screen.dart';
import '../../controller/cubit/products_cubit.dart';

class BottomSheetItem extends StatelessWidget {
  const BottomSheetItem({
    Key? key,
    required this.screenHeight,
  }) : super(key: key);

  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      child: Column(
        children: [
          Row(
            children: [
              SvgPicture.asset(
                'assets/images/check.svg',
                color: AppConstants.primaryColor,
                width: 30.w,
                height: 30.h,
              ),
              SizedBox(
                width: 15.w,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ProductsCubit.get(context)
                        .productDetailsModel!
                        .productName!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const Text(
                    'Added to cart',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: AppConstants.primaryColor),
                  )
                ],
              )
            ],
          ),
          SizedBox(
            height: screenHeight * 0.02,
          ),
          CustomElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            text: 'Continue Shopping',
          ),
          SizedBox(
            height: screenHeight * 0.02,
          ),
          CustomElevatedButton(
            onPressed: () {
              HomeLayoutCubit.get(context).currentIndex = 3;
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const HomeLayoutScreen(),
              ));
            },
            text: 'View Cart',
          )
        ],
      ),
    );
  }
}
