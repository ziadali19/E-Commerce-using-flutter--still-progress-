import 'package:e_commerce/core/utilis/constants.dart';

import 'package:e_commerce/features/favorite/controller/cubit/favorite_cubit.dart';
import 'package:e_commerce/features/filter/controller/cubit/filter_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../filter/presentation/screens/filter_screen.dart';
import '../../../search/presentaion/screens/search_screen.dart';
import '../../controller/cubit/home_layout_cubit.dart';

AppBar homeLayoutAppBar(HomeLayoutCubit cubit, BuildContext context) {
  return AppBar(
    leading: const SizedBox(),
    actions: [
      SizedBox(
        width: 20.w,
      ),
      SvgPicture.asset(
        'assets/images/Vector.svg',
        width: 30.w,
      ),
      const Spacer(),
      Container(
        transform: Matrix4.translationValues(5.w, 15.h, 0),
        child: Text(
          cubit.titles[cubit.currentIndex],
          style: TextStyle(
              color: Colors.black,
              fontSize: 20.sp,
              fontWeight: FontWeight.w500),
        ),
      ),
      const Spacer(),
      cubit.currentIndex == 2
          ? IconButton(
              onPressed: () {
                FavoriteCubit.get(context).getFavorites(token!, favPageNumber);
              },
              icon: SvgPicture.asset(
                'assets/images/refresh.svg',
                width: 30.w,
                height: 30.h,
                color: const Color.fromARGB(255, 0, 0, 0),
              ))
          : cubit.currentIndex == 1
              ? IconButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const FilterScreen(),
                    ));
                    subCategoryId = '';
                    categoryId = '';

                    subCategory = '';
                    brandId = '';
                    brand = '';
                    orderByPrice = '';
                    orderByPriceValue = '';
                    id = 0;
                    FilterCubit.get(context).resetFilters();
                  },
                  icon: SvgPicture.asset(
                    'assets/images/filter-6551.svg',
                    width: 27.w,
                    height: 27.h,
                    color: Colors.black,
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
