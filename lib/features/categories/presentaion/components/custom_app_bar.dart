import 'package:e_commerce/features/search/presentaion/screens/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

AppBar customAppBar(BuildContext context, String title,
    [Function()? resetFilters]) {
  return AppBar(
    actions: [
      SizedBox(
        width: 70.w,
      ),
      SvgPicture.asset(
        'assets/images/Vector.svg',
        width: 30.w,
      ),
      const Spacer(),
      Center(
        child: Container(
          transform: Matrix4.translationValues(-14.w, 2.h, 0),
          child: Text(
            title,
            style: TextStyle(
                color: Colors.black,
                fontSize: 20.sp,
                fontWeight: FontWeight.w500),
          ),
        ),
      ),
      const Spacer(),
      title == 'Search'
          ? SizedBox(
              width: 45.w,
            )
          : title == 'Filters'
              ? IconButton(
                  onPressed: resetFilters,
                  icon: SvgPicture.asset(
                    'assets/images/refresh.svg',
                    width: 30.w,
                    height: 30.h,
                  ))
              : IconButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const SearchScreen(),
                    ));
                  },
                  icon: SvgPicture.asset(
                    'assets/images/Search.svg',
                    width: 30.w,
                    height: 30.h,
                  )),
      SizedBox(
        width: 20.w,
      )
    ],
  );
}
