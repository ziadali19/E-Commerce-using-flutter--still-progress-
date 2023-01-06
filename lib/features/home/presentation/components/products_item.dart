import 'package:e_commerce/features/product/presentaion/screens/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/utilis/constants.dart';
import '../../../product/controller/cubit/products_cubit.dart';
import '../../controller/cubit/home_cubit.dart';

SizedBox productsItem(HomeCubit cubit, double screenHeight) {
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
                    lst: cubit.products,
                    index: index,
                  ),
                ));
                ProductsCubit.get(context).getProductDetails(
                    cubit.products[index].productId,
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
                                image: NetworkImage(
                                    cubit.products[index].productImage!))),
                      ),
                      Text(
                        cubit.products[index].productName!,
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
                      Text(cubit.products[index].priceAfterDiscount!,
                          style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.black)),
                      cubit.products[index].priceAfterDiscount !=
                              cubit.products[index].price
                          ? Row(
                              children: [
                                Text('${cubit.products[index].price!} ',
                                    style: TextStyle(
                                        fontSize: 10.sp,
                                        fontWeight: FontWeight.w400,
                                        decoration: TextDecoration.lineThrough,
                                        color: Colors.black)),
                                Text(' ${cubit.products[index].discount!} OFF',
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
                            child: GestureDetector(
                              child: SvgPicture.asset(
                                'assets/images/favorite.svg',
                                width: 20.w,
                              ),
                              onTap: () {},
                            ),
                          ),
                          const Spacer(),
                          Container(
                            padding: const EdgeInsets.all(3),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: cubit.products[index].rating! >= 4
                                    ? Colors.green
                                    : (cubit.products[index].rating) >= 3
                                        ? const Color.fromARGB(255, 74, 114, 76)
                                        : Colors.grey),
                            child: Row(
                              children: [
                                Text(cubit.products[index].rating!.toString(),
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
          itemCount: cubit.products.length));
}
