import 'package:e_commerce/core/utilis/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../categories/controller/cubit/categories_cubit.dart';
import '../../../categories/controller/cubit/category_details_cubit.dart';
import '../../../categories/presentaion/screens/category_details_screen.dart';
import '../../controller/cubit/home_cubit.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({
    Key? key,
    required this.screenHeight,
    required this.cubit,
    required this.screenWidth,
  }) : super(key: key);

  final double screenHeight;
  final HomeCubit cubit;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: screenHeight * 0.1,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: cubit.categories.length,
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(
            width: 17.w,
          );
        },
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const CategoryDetailsScreen(),
              ));
              CategoryDetailsCubit.get(context)
                  .categoryDetails(cubit.categories[index].id, 1);
            },
            child: SizedBox(
              width: screenWidth * 0.25,
              child: Column(
                children: [
                  SizedBox(
                      height: 50.h,
                      width: 30.w,
                      child: SvgPicture.asset(
                        AppConstants.categoriesIcons[index],
                        color: AppConstants.primaryColor,
                      ))
                  /* Image.network(
                    'https://media.istockphoto.com/id/163208487/photo/male-coat-isolated-on-the-white.jpg?s=612x612&w=0&k=20&c=3Sdq5xnVS2jOYPNXI6JLwAumzyelcP_VgKVW0MVUhwo=',
                    fit: BoxFit.cover,
                    height: screenHeight * 0.15,
                  )*/
                  ,
                  SizedBox(
                    height: 7.h,
                  ),
                  Text(
                    cubit.categories[index].name!,
                    style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
