import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LogoAndTitle extends StatelessWidget {
  const LogoAndTitle({
    Key? key,
    required this.screenHeight,
    required this.screenWidth,
  }) : super(key: key);

  final double screenHeight;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: screenHeight * 0.12,
        ),
        SvgPicture.asset(
          'assets/images/Vector.svg',
          width: screenWidth * 0.144,
          height: screenHeight * 0.076,
        ),
        SizedBox(
          height: screenHeight * 0.046,
        ),
        Text(
          'Sign up',
          style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w500),
        ),
        SizedBox(
          height: screenHeight * 0.0406,
        ),
      ],
    );
  }
}
