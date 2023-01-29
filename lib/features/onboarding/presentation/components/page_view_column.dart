import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/common/custom_elevated_button.dart';
import '../../../../core/utilis/cashe_helper.dart';
import '../../../../core/utilis/constants.dart';
import '../../../login/presentaions/screens/login_screen.dart';
import '../../controller/cubit/on_boarding_cubit.dart';

class PageViewColumn extends StatelessWidget {
  const PageViewColumn({
    Key? key,
    required this.screenWidth,
    required this.screenHeight,
    required this.cubit,
    required this.pageController,
    required this.index,
  }) : super(key: key);

  final double screenWidth;
  final double screenHeight;
  final OnBoardingCubit cubit;
  final PageController pageController;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.058),
      child: Column(
        children: [
          SizedBox(
            height: screenHeight * 0.068,
          ),
          SvgPicture.asset(AppConstants.images[index]),
          SizedBox(
            height: screenHeight * 0.0467,
          ),
          Text(
            AppConstants.titles[index],
            style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: screenHeight * 0.0197,
          ),
          Text(
            AppConstants.body[index],
            textAlign: TextAlign.center,
            style: TextStyle(
                color: AppConstants.blackColor.withOpacity(0.5),
                fontSize: 14.sp,
                fontWeight: FontWeight.w400),
          ),
          SizedBox(
            height: screenHeight * 0.043,
          ),
          CustomElevatedButton(
              index: index,
              onPressed: () {
                pageController.nextPage(
                    duration: const Duration(milliseconds: 700),
                    curve: Curves.easeInOutExpo);
                if (cubit.pageIndex == 2) {
                  CasheHelper.saveData('onBoarding', true).then((value) {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const LoginScreen()));
                  });
                }
              })
        ],
      ),
    );
  }
}
