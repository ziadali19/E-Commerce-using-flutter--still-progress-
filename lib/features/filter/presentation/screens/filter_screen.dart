import 'package:e_commerce/core/common/custom_elevated_button.dart';

import 'package:e_commerce/features/categories/presentaion/components/category_product_item.dart';
import 'package:e_commerce/features/categories/presentaion/components/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

import '../../../../core/utilis/constants.dart';
import '../../controller/cubit/filter_cubit.dart';
import '../components/filter_list_view_item.dart';

dynamic subCategoryId = '';
dynamic categoryId = '';
String subCategory = '';
dynamic brandId = '';
String brand = '';
String orderByPrice = '';
String orderByPriceValue = '';
int id = 0;

class FilterScreen extends StatelessWidget {
  const FilterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return BlocConsumer<FilterCubit, FilterState>(
      listener: (context, state) {
        if (state is GetFilteredListError) {
          AppConstants().showSnackBar(state.errorMessage, context, Colors.red);
        }
      },
      builder: (context, state) {
        FilterCubit cubit = FilterCubit.get(context);
        return Scaffold(
            appBar: customAppBar(context, 'Filters', () {
              subCategoryId = '';
              categoryId = '';

              subCategory = '';
              brandId = '';
              brand = '';
              orderByPrice = '';
              orderByPriceValue = '';
              id = 0;
              cubit.resetFilters();
            }),
            body: cubit.categoriesList.isNotEmpty
                ? Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                    child: LazyLoadScrollView(
                      onEndOfPage: () {
                        cubit.filterLoadMore(
                          categoryId: categoryId,
                          subCategory: subCategory,
                          subCategoryId: subCategoryId,
                          brand: brand,
                          brandId: brandId,
                          discount: '',
                          discountPercentage: '',
                          priceFrom: 'price_from',
                          priceTo: 'price_to',
                          startPrice: cubit.startPrice,
                          endPrice: cubit.endPrice,
                          orderByPrice: orderByPrice,
                          orderByPriceValue: orderByPriceValue,
                          rating: '',
                          ratingValue: '',
                        );
                      },
                      child: ListView(
                        children: [
                          const Text(
                            'Categories',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          SizedBox(
                            height: 50.h,
                            child: ListView.builder(
                              itemCount: cubit.categoriesList.length,
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (BuildContext context, int index) {
                                return FilterListViewItem(
                                  name: cubit.categoriesList[index].name!,
                                  color: cubit.categoryClicked == true &&
                                          categoryId ==
                                              cubit.categoriesList[index].id!
                                      ? AppConstants.primaryColor
                                      : Colors.grey[300],
                                  cubit: cubit,
                                  index: index,
                                  onTap: () async {
                                    cubit.changeCategoryCardColor();
                                    subCategory = '';
                                    brand = '';
                                    subCategoryId = '';
                                    brandId = '';
                                    cubit.subCategoryDetailsModel = null;
                                    await cubit.categoryDetails(
                                        cubit.categoriesList[index].id);
                                    cubit.subCategoryVisibilty();

                                    categoryId =
                                        cubit.categoriesList[index].id!;
                                  },
                                );
                              },
                            ),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Visibility(
                            visible: cubit.isSubCategoryVisible,
                            child: cubit.categoryDetailsModel != null
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Sub Categories',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      SizedBox(
                                        height: 50.h,
                                        child: ListView.builder(
                                          itemCount: cubit.categoryDetailsModel!
                                              .subCategories.length,
                                          shrinkWrap: true,
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return FilterListViewItem(
                                                cubit: cubit,
                                                index: index,
                                                onTap: () {
                                                  cubit
                                                      .changeSubCategoryCardColor();
                                                  brand = '';
                                                  brandId = '';
                                                  cubit.subCategoryDetails(cubit
                                                      .categoryDetailsModel!
                                                      .subCategories[index]
                                                      .id);
                                                  subCategoryId = cubit
                                                      .categoryDetailsModel!
                                                      .subCategories[index]
                                                      .id;
                                                  subCategory = 'sub-category';
                                                },
                                                color: cubit.subCategoryClicked ==
                                                            true &&
                                                        subCategoryId ==
                                                            cubit
                                                                .categoryDetailsModel!
                                                                .subCategories[
                                                                    index]
                                                                .id
                                                    ? AppConstants.primaryColor
                                                    : Colors.grey[300],
                                                name: cubit
                                                    .categoryDetailsModel!
                                                    .subCategories[index]
                                                    .name!);
                                          },
                                        ),
                                      ),
                                    ],
                                  )
                                : const Center(
                                    child: LinearProgressIndicator(),
                                  ),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Visibility(
                            visible: cubit.isSubCategoryVisible,
                            child: cubit.categoryDetailsModel != null
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Brands',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      cubit.isLoading == true
                                          ? const Center(
                                              child: LinearProgressIndicator())
                                          : SizedBox(
                                              height: 50.h,
                                              child: ListView.builder(
                                                itemCount: cubit
                                                            .subCategoryDetailsModel ==
                                                        null
                                                    ? cubit
                                                        .categoryDetailsModel!
                                                        .brands
                                                        .length
                                                    : cubit
                                                        .subCategoryDetailsModel!
                                                        .brands
                                                        .length,
                                                shrinkWrap: true,
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  return FilterListViewItem(
                                                      cubit: cubit,
                                                      index: index,
                                                      onTap: () {
                                                        cubit
                                                            .changeBrandCardColor();
                                                        cubit.subCategoryDetailsModel ==
                                                                null
                                                            ? brandId = cubit
                                                                .categoryDetailsModel!
                                                                .brands[index]
                                                                .id
                                                            : brandId = cubit
                                                                .subCategoryDetailsModel!
                                                                .brands[index]
                                                                .id;
                                                        brand = 'brand';
                                                      },
                                                      color: cubit.brandClicked ==
                                                                      true &&
                                                                  brandId ==
                                                                      cubit
                                                                          .categoryDetailsModel!
                                                                          .brands[
                                                                              index]
                                                                          .id ||
                                                              cubit.brandClicked ==
                                                                      true &&
                                                                  brandId ==
                                                                      cubit
                                                                          .subCategoryDetailsModel!
                                                                          .brands[
                                                                              index]
                                                                          .id
                                                          ? AppConstants
                                                              .primaryColor
                                                          : Colors.grey[300],
                                                      name: cubit.subCategoryDetailsModel !=
                                                              null
                                                          ? cubit
                                                              .subCategoryDetailsModel!
                                                              .brands[index]
                                                              .name!
                                                          : cubit
                                                              .categoryDetailsModel!
                                                              .brands[index]
                                                              .name!);
                                                },
                                              ),
                                            ),
                                    ],
                                  )
                                : const Center(
                                    child: LinearProgressIndicator(),
                                  ),
                          ),
                          const Text(
                            'Price',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Row(
                            children: [
                              Text('${cubit.startPrice.round()} EGP'),
                              const Spacer(),
                              Text('${cubit.endPrice.round()} EGP')
                            ],
                          ),
                          RangeSlider(
                            min: 1,
                            max: 30000,
                            divisions: 300,
                            onChanged: (value) {
                              cubit.sliderValu(value);
                            },
                            values:
                                RangeValues(cubit.startPrice, cubit.endPrice),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          const Text(
                            'Order by Price',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          SizedBox(
                            height: 50.h,
                            child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: cubit.orderByPrice.length,
                              itemBuilder: (BuildContext context, int index) {
                                return FilterListViewItem(
                                    cubit: cubit,
                                    index: index,
                                    onTap: () {
                                      cubit.changeOrderByPriceCardColor();
                                      if (index == 0) {
                                        orderByPrice = 'orderByPrice';
                                        orderByPriceValue = 'low';
                                        id = index;
                                      } else {
                                        orderByPrice = 'orderByPrice';
                                        orderByPriceValue = 'high';
                                        id = index;
                                      }
                                    },
                                    color: cubit.orderByPriceClicked == true &&
                                            id == index
                                        ? AppConstants.primaryColor
                                        : Colors.grey[300],
                                    name: cubit.orderByPrice[index]);
                              },
                            ),
                          ),
                          SizedBox(
                            height: 30.h,
                          ),
                          Center(
                            child: CustomElevatedButton(
                              onPressed: () {
                                cubit.filterProducts(
                                  categoryId: categoryId,
                                  subCategory: subCategory,
                                  subCategoryId: subCategoryId,
                                  brand: brand,
                                  brandId: brandId,
                                  discount: '',
                                  discountPercentage: '',
                                  priceFrom: 'price_from',
                                  priceTo: 'price_to',
                                  startPrice: cubit.startPrice,
                                  endPrice: cubit.endPrice,
                                  orderByPrice: orderByPrice,
                                  orderByPriceValue: orderByPriceValue,
                                  rating: '',
                                  ratingValue: '',
                                );
                              },
                              text: 'Show results',
                            ),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          state is GetFilteredListLoading
                              ? const Center(
                                  child: LinearProgressIndicator(),
                                )
                              : state is GetFilteredListSuccess &&
                                      cubit.filteredList.isNotEmpty
                                  ? categoryProductItem(
                                      screenHeight: screenHeight,
                                      itemCount: cubit.filteredList.length,
                                      lst: cubit.filteredList,
                                      context: context,
                                      filterCubit: cubit,
                                      txt: 'Products')
                                  : state is GetFilteredListSuccess &&
                                          cubit.filteredList.isEmpty
                                      ? const Center(
                                          child: Text(
                                          'No results matched the filters',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ))
                                      : categoryProductItem(
                                          screenHeight: screenHeight,
                                          itemCount: cubit.filteredList.length,
                                          lst: cubit.filteredList,
                                          context: context,
                                          filterCubit: cubit,
                                          txt: 'Products')
                        ],
                      ),
                    ))
                : const Center(
                    child: CircularProgressIndicator(),
                  ));
      },
    );
  }
}
