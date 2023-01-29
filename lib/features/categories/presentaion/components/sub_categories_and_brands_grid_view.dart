import 'package:e_commerce/features/categories/controller/cubit/category_details_cubit.dart';
import 'package:e_commerce/features/categories/data/models/category_details_model.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utilis/constants.dart';
import '../../controller/cubit/brand_details_cubit.dart';
import '../../controller/cubit/categories_cubit.dart';
import '../../controller/cubit/sub_categories_details_cubit.dart';
import '../../data/models/sub_category_details_model.dart';
import '../screens/brand_screen.dart';
import '../screens/category_details_screen.dart';

import '../screens/sub_category_screen.dart';

class SubCategoriesAndBrandsGridView extends StatelessWidget {
  const SubCategoriesAndBrandsGridView(
      {Key? key,
      required this.header,
      required this.itemCount,
      required this.lst,
      this.categoryDetailsModel,
      this.subCategoryDetailsModel})
      : super(key: key);
  final String header;

  final List lst;

  final int? itemCount;
  final CategoryDetailsModel? categoryDetailsModel;
  final SubCategoryDetailsModel? subCategoryDetailsModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          header,
          style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w500,
              color: Colors.black),
        ),
        SizedBox(
          height: 17.h,
        ),
        SizedBox(
          height: 180.h,
          child: GridView.builder(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 10.w,
                crossAxisSpacing: 10.h,
                childAspectRatio: 1 / 3),
            itemCount: itemCount,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                hoverColor: AppConstants.primaryColor,
                borderRadius: BorderRadius.circular(10.r),
                onTap: () {
                  if (header == 'Brands') {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const BrandScreen(),
                    ));
                    BrandDetailsCubit.get(context).brandDetails(
                        CategoriesCubit.get(context).brandsList[index].id!,
                        BrandDetailsCubit.get(context).brandPageNumber);
                  } else if (header == 'Sub Categories') {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const SubCategoryScreen()));

                    SubCategoriesDetailsCubit.get(context).subCategoryDetails(
                        CategoriesCubit.get(context)
                            .subCategoriesList[index]
                            .id!,
                        SubCategoriesDetailsCubit.get(context)
                            .subCategoryPageNumber);
                  } else {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const CategoryDetailsScreen(),
                    ));
                    CategoryDetailsCubit.get(context).categoryDetails(
                        CategoriesCubit.get(context).categoriesList[index].id,
                        CategoryDetailsCubit.get(context)
                            .categoryDetailspageNumber);
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10.r)),
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                  child: Center(
                    child: Text(
                      lst[index].name,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontWeight: FontWeight.w500, color: Colors.black),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
