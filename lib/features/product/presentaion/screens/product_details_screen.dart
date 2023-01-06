import 'package:e_commerce/core/common/custom_elevated_button.dart';

import 'package:e_commerce/features/product/presentaion/components/product_shimmer_effect.dart';
import 'package:e_commerce/features/product/presentaion/components/reviews_comments.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

import '../../../../core/utilis/constants.dart';
import '../../../../main.dart';
import '../../../categories/presentaion/components/custom_app_bar.dart';
import '../../controller/cubit/products_cubit.dart';
import '../components/bottom_sheet_item.dart';
import '../components/image_indicator.dart';
import '../components/image_slider.dart';
import '../components/overview_item.dart';
import '../components/price_and_discount.dart';
import '../components/product_name_and_rating.dart';
import '../components/users_reviews_rating.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen(
      {super.key, required this.lst, required this.index});
  final List lst;
  final int index;
  @override
  Widget build(BuildContext context) {
    @override
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return BlocConsumer<ProductsCubit, ProductsState>(
      listener: (context, state) {
        if (state is GetProductDetailsError) {
          AppConstants().showSnackBar(state.error, context, Colors.red);
          Navigator.of(context).pop();
        }
        if (state is AddToCartError) {
          AppConstants().showSnackBar(state.error, context, Colors.red);
        }
        if (state is AddToCartSuccess) {
          showModalBottomSheet(
            constraints: BoxConstraints(
                maxHeight: screenHeight * 0.3, maxWidth: screenWidth),
            elevation: 0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.r)),
            context: context,
            builder: (context) {
              return BottomSheetItem(screenHeight: screenHeight);
            },
          );
        }
      },
      builder: (context, state) {
        ProductsCubit cubit = ProductsCubit.get(context);

        return cubit.productDetailsModel != null
            ? Scaffold(
                appBar: customAppBar(context, ''),
                body: LazyLoadScrollView(
                  onEndOfPage: () {
                    cubit.reviewsLoadMore(id: lst[index].productId);
                  },
                  child: ListView(children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.w, vertical: 20.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          productNameAndRating(cubit),
                          SizedBox(
                            height: screenHeight * 0.02,
                          ),
                          ImageSlider(
                              cubit: cubit,
                              screenHeight: screenHeight,
                              screenWidth: screenWidth),
                          SizedBox(
                            height: screenHeight * 0.02,
                          ),
                          ImageIndicator(cubit: cubit),
                          SizedBox(
                            height: screenHeight * 0.02,
                          ),
                          PriceAndDiscount(cubit: cubit),
                          SizedBox(
                            height: screenHeight * 0.03,
                          ),
                          OverView(cubit: cubit),
                          SizedBox(
                            height: screenHeight * 0.03,
                          ),
                          Row(
                            children: [
                              Text(
                                'User reviews',
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black),
                              ),
                              const Spacer(),
                              userReviewsRating(cubit),
                            ],
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount:
                                cubit.productDetailsModel!.reviews.length,
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return Column(
                                children: [
                                  SizedBox(
                                    height: 7.h,
                                  ),
                                  Divider(
                                    height: 1,
                                    color: Colors.grey[500],
                                  ),
                                  SizedBox(
                                    height: 7.h,
                                  ),
                                ],
                              );
                            },
                            itemBuilder: (BuildContext context, int index) {
                              return reviewsComments(cubit, index);
                            },
                          ),
                          SizedBox(
                            height: screenHeight * 0.08,
                          )
                        ],
                      ),
                    )
                  ]),
                ),
                floatingActionButton: state is AddToCartLoading
                    ? const CircularProgressIndicator()
                    : CustomElevatedButton(
                        onPressed: () {
                          if (cubit.productDetailsModel!.stock ==
                              'out of stock') {
                            AppConstants().showSnackBar(
                                'This Product is Currently Out of Stock',
                                context,
                                Colors.red);
                          } else {
                            cubit.addToCart(
                                cubit.productDetailsModel!.productId,
                                token!,
                                context);
                          }
                        },
                        text: 'Add to cart',
                        index: 3,
                      ),
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.centerFloat,
              )
            : Scaffold(
                appBar: customAppBar(context, ''),
                body: productShimmerEffect(screenHeight, screenWidth),
              );
      },
    );
  }
}
