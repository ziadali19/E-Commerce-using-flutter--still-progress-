import 'package:e_commerce/features/product/presentaion/screens/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/utilis/constants.dart';
import '../../../product/controller/cubit/products_cubit.dart';
import '../../controller/cubit/home_cubit.dart';

SizedBox productsItem(HomeCubit cubit, double screenHeight, lst, ctx) {
  return SizedBox(
      height: 350.h,
      child: ListView.separated(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ProductDetailsScreen(
                    lst: lst,
                    index: index,
                  ),
                ));
                ProductsCubit.get(context).getProductDetails(
                    lst[index].productId,
                    ProductsCubit.get(context).productPageNumber);
              },
              child: Container(
                width: 150.w,
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
                      SizedBox(
                        height: 5.h,
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
                              child: cubit.favBestOffersValues[lst[index]
                                              .productId
                                              .toString()] ==
                                          false ||
                                      cubit.favBestSellerValues[lst[index]
                                              .productId
                                              .toString()] ==
                                          false ||
                                      cubit.favNewArrivalValues[lst[index]
                                              .productId
                                              .toString()] ==
                                          false ||
                                      cubit.favTopRatedValues[lst[index]
                                              .productId
                                              .toString()] ==
                                          false ||
                                      cubit.favTrendingValues[lst[index]
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
                                      color:
                                          const Color.fromARGB(255, 218, 19, 5),
                                    ),
                              onTap: () {
                                cubit.addOrRemoveFromFavHomePage(
                                    lst[index].productId, token!, ctx);
                              },
                            ),
                          ),
                          const Spacer(),
                          Container(
                            padding: const EdgeInsets.all(3),
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
                                  transform:
                                      Matrix4.translationValues(0, -1.7, 0),
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
          separatorBuilder: (context, index) {
            return SizedBox(
              width: 10.w,
            );
          },
          itemCount: lst.length));
}
