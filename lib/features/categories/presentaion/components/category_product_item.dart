import 'package:e_commerce/features/categories/controller/cubit/brand_details_cubit.dart';
import 'package:e_commerce/features/categories/controller/cubit/sub_categories_details_cubit.dart';
import 'package:e_commerce/features/favorite/controller/cubit/favorite_cubit.dart';
import 'package:e_commerce/features/filter/controller/cubit/filter_cubit.dart';
import 'package:e_commerce/features/product/controller/cubit/products_cubit.dart';
import 'package:e_commerce/features/product/presentaion/screens/product_details_screen.dart';
import 'package:e_commerce/features/search/controller/cubit/search_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/utilis/constants.dart';
import '../../../../main.dart';
import '../../controller/cubit/category_details_cubit.dart';
import '../../data/models/category_details_model.dart';

GridView categoryProductItem(
    {CategoryDetailsModel? categoryDetailsModel,
    required double screenHeight,
    FavoriteCubit? favoriteCubit,
    CategoryDetailsCubit? categoryDetailsCubit,
    SubCategoriesDetailsCubit? subCategoriesDetailsCubit,
    BrandDetailsCubit? brandDetailsCubit,
    FilterCubit? filterCubit,
    SearchCubit? searchCubit,
    required int itemCount,
    required List lst,
    required BuildContext context,
    required String txt}) {
  return GridView.builder(
    physics: const BouncingScrollPhysics(),
    shrinkWrap: true,
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisSpacing: 10.h,
        crossAxisSpacing: 10.w,
        crossAxisCount: 2,
        mainAxisExtent: 350.h),
    itemCount: itemCount,
    itemBuilder: (BuildContext context, int index) {
      return GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ProductDetailsScreen(
              lst: lst,
              index: index,
            ),
          ));
          ProductsCubit.get(context).getProductDetails(lst[index].productId,
              ProductsCubit.get(context).productPageNumber);
        },
        child: Container(
          width: 150.w,
          height: 350.h,
          decoration: BoxDecoration(
              color: AppConstants.backgroundColor,
              borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 200.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(lst[index].productImage!))),
                ),
                Text(
                  lst[index].productName!,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                ),
                SizedBox(
                  height: screenHeight * 0.02,
                ),
                Text(lst[index].priceAfterDiscount!,
                    style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.black)),
                lst[index].priceAfterDiscount != lst[index].price
                    ? Row(
                        children: [
                          Text('${lst[index].price!} ',
                              style: TextStyle(
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w400,
                                  decoration: TextDecoration.lineThrough,
                                  color: Colors.black)),
                          Text(' ${lst[index].discount!} OFF',
                              style: TextStyle(
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black))
                        ],
                      )
                    : SizedBox(
                        height: 17.h,
                      ),
                SizedBox(
                  height: screenHeight * 0.02,
                ),
                Row(
                  children: [
                    Container(
                      transform: Matrix4.translationValues(0, -1.5, 0),
                      child: InkWell(
                        child: categoryDetailsCubit != null &&
                                subCategoriesDetailsCubit == null &&
                                brandDetailsCubit == null &&
                                favoriteCubit == null &&
                                filterCubit == null
                            ? categoryDetailsCubit.favValues[
                                        lst[index].productId.toString()] ==
                                    false
                                ? SvgPicture.asset(
                                    'assets/images/favorite.svg',
                                    width: 20.w,
                                  )
                                : SvgPicture.asset(
                                    'assets/images/favorite1.svg',
                                    width: 20.w,
                                    color:
                                        const Color.fromARGB(255, 218, 19, 5),
                                  )
                            : categoryDetailsCubit == null &&
                                    subCategoriesDetailsCubit != null &&
                                    brandDetailsCubit == null &&
                                    favoriteCubit == null &&
                                    filterCubit == null
                                ? subCategoriesDetailsCubit.subCategoryFavValues[
                                            lst[index].productId.toString()] ==
                                        false
                                    ? SvgPicture.asset(
                                        'assets/images/favorite.svg',
                                        width: 20.w,
                                      )
                                    : SvgPicture.asset(
                                        'assets/images/favorite1.svg',
                                        width: 20.w,
                                        color: const Color.fromARGB(
                                            255, 218, 19, 5),
                                      )
                                : categoryDetailsCubit == null &&
                                        subCategoriesDetailsCubit == null &&
                                        brandDetailsCubit != null &&
                                        favoriteCubit == null &&
                                        filterCubit == null
                                    ? brandDetailsCubit.brandFavValues[lst[index]
                                                .productId
                                                .toString()] ==
                                            false
                                        ? SvgPicture.asset(
                                            'assets/images/favorite.svg',
                                            width: 20.w,
                                          )
                                        : SvgPicture.asset(
                                            'assets/images/favorite1.svg',
                                            width: 20.w,
                                            color: const Color.fromARGB(
                                                255, 218, 19, 5),
                                          )
                                    : categoryDetailsCubit == null &&
                                            subCategoriesDetailsCubit == null &&
                                            brandDetailsCubit == null &&
                                            favoriteCubit != null &&
                                            filterCubit == null
                                        ? favoriteCubit.favValues[lst[index]
                                                    .productId
                                                    .toString()] ==
                                                false
                                            ? SvgPicture.asset(
                                                'assets/images/favorite.svg',
                                                width: 20.w,
                                              )
                                            : SvgPicture.asset(
                                                'assets/images/favorite1.svg',
                                                width: 20.w,
                                                color: const Color.fromARGB(
                                                    255, 218, 19, 5),
                                              )
                                        : categoryDetailsCubit == null &&
                                                subCategoriesDetailsCubit ==
                                                    null &&
                                                brandDetailsCubit == null &&
                                                favoriteCubit == null &&
                                                filterCubit != null
                                            ? filterCubit.filterFavValues[lst[index].productId.toString()] == false
                                                ? SvgPicture.asset(
                                                    'assets/images/favorite.svg',
                                                    width: 20.w,
                                                  )
                                                : SvgPicture.asset(
                                                    'assets/images/favorite1.svg',
                                                    width: 20.w,
                                                    color: const Color.fromARGB(
                                                        255, 218, 19, 5),
                                                  )
                                            : SvgPicture.asset(
                                                'assets/images/favorite.svg',
                                                width: 20.w,
                                              ),
                        onTap: () {
                          if (categoryDetailsCubit != null &&
                              subCategoriesDetailsCubit == null &&
                              brandDetailsCubit == null &&
                              favoriteCubit == null &&
                              filterCubit == null) {
                            categoryDetailsCubit
                                .addOrRemoveFromFavoriteCategoryDetails(
                                    lst[index].productId, token!, context);
                          } else if (categoryDetailsCubit == null &&
                              subCategoriesDetailsCubit != null &&
                              brandDetailsCubit == null &&
                              favoriteCubit == null &&
                              filterCubit == null) {
                            subCategoriesDetailsCubit
                                .addOrRemoveFromFavoriteSubCategoryDetails(
                                    lst[index].productId, token!, context);
                          } else if (categoryDetailsCubit == null &&
                              subCategoriesDetailsCubit == null &&
                              brandDetailsCubit != null &&
                              favoriteCubit == null &&
                              filterCubit == null) {
                            brandDetailsCubit
                                .addOrRemoveFromFavoriteBrandDetails(
                                    lst[index].productId, token!, context);
                          } else if (categoryDetailsCubit == null &&
                              subCategoriesDetailsCubit == null &&
                              brandDetailsCubit == null &&
                              favoriteCubit != null &&
                              filterCubit == null) {
                            favoriteCubit.addOrRemoveFromFavorite(
                                lst[index].productId, token!, context);
                          } else if (categoryDetailsCubit == null &&
                              subCategoriesDetailsCubit == null &&
                              brandDetailsCubit == null &&
                              favoriteCubit == null &&
                              filterCubit != null) {
                            filterCubit.addOrRemoveFromFavFilter(
                                lst[index].productId, token!, context);
                          } else {
                            print('dirty');
                          }
                        },
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 3.w, vertical: 3.h),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: lst[index].rating! >= 4
                              ? Colors.green
                              : (lst[index].rating) >= 3
                                  ? const Color.fromARGB(255, 74, 114, 76)
                                  : Colors.grey),
                      child: Row(
                        children: [
                          Text(lst[index].rating!.toString(),
                              style: TextStyle(
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white)),
                          Container(
                            transform: Matrix4.translationValues(0, -1.7, 0),
                            child: const Icon(
                              Icons.star_rounded,
                              size: 15,
                              color: Color.fromARGB(255, 249, 216, 2),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      );
    },
  );
}
