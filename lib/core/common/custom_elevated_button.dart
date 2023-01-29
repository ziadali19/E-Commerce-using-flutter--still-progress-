import 'package:e_commerce/core/utilis/constants.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomElevatedButton extends StatelessWidget {
  final int? index;
  final Function()? onPressed;
  final String? text;
  CustomElevatedButton(
      {super.key, this.index, this.text, required this.onPressed});
  final List titles = ['Next', 'Next', 'Get Started'];
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.581,
      height: MediaQuery.of(context).size.height * 0.0726,
      child: ElevatedButton(
          style: ButtonStyle(
              elevation: MaterialStateProperty.all(0),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(133.r))),
              foregroundColor: const MaterialStatePropertyAll(Colors.white),
              textStyle: MaterialStateProperty.all(TextStyle(
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Gordita',
                  fontSize: 16.sp)),
              backgroundColor:
                  const MaterialStatePropertyAll(AppConstants.primaryColor)),
          onPressed: onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text ?? titles[index!],
              ),
              index != null
                  ? (index == 0
                      ? SvgPicture.asset('assets/images/arrow.svg')
                      : (index == 1
                          ? Row(
                              children: [
                                SvgPicture.asset('assets/images/arrow.svg',
                                    color: Colors.white.withOpacity(0.5)),
                                Container(
                                    transform: Matrix4.translationValues(
                                        -MediaQuery.of(context).size.width *
                                            0.03,
                                        0,
                                        0),
                                    child: SvgPicture.asset(
                                        'assets/images/arrow.svg')),
                              ],
                            )
                          : (index == 2
                              ? Row(
                                  children: [
                                    SvgPicture.asset('assets/images/arrow.svg',
                                        color: Colors.white.withOpacity(0.5)),
                                    Container(
                                        transform: Matrix4.translationValues(
                                            -MediaQuery.of(context).size.width *
                                                0.03,
                                            0,
                                            0),
                                        child: SvgPicture.asset(
                                          'assets/images/arrow.svg',
                                          color: Colors.white.withOpacity(0.5),
                                        )),
                                    Container(
                                        transform: Matrix4.translationValues(
                                            -MediaQuery.of(context).size.width *
                                                0.06,
                                            0,
                                            0),
                                        child: SvgPicture.asset(
                                            'assets/images/arrow.svg'))
                                  ],
                                )
                              : index == 3
                                  ? Row(
                                      children: [
                                        SizedBox(
                                          width: 5.w,
                                        ),
                                        SvgPicture.asset(
                                            'assets/images/addtocart.svg'),
                                      ],
                                    )
                                  : const Text(''))))
                  : const Text('')
            ],
          )),
    );
  }
}
