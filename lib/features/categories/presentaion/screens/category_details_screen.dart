import 'package:e_commerce/core/utilis/constants.dart';

import 'package:e_commerce/features/categories/presentaion/components/category_details_shimmer_effect.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

import '../../controller/cubit/category_details_cubit.dart';

import '../components/category_product_item.dart';
import '../components/custom_app_bar.dart';

class CategoryDetailsScreen extends StatelessWidget {
  const CategoryDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return BlocConsumer<CategoryDetailsCubit, CategoryDetailsState>(
      listener: (context, state) {
        if (state is GetCategoryDetailError) {
          AppConstants().showSnackBar(state.error, context, Colors.red);
          Navigator.of(context).pop();
        }
        if (state is AddOrRemoveFavCategoryDetailsError) {
          AppConstants().showSnackBar(state.errorMsg, context, Colors.red);
        }
      },
      builder: (context, state) {
        CategoryDetailsCubit cubit = CategoryDetailsCubit.get(context);
        return cubit.categoryDetailsModel != null
            ? Scaffold(
                appBar:
                    customAppBar(context, cubit.categoryDetailsModel!.name!),
                body: LazyLoadScrollView(
                    onEndOfPage: () {
                      cubit.categoryMoreData(
                          id: cubit.categoryDetailsModel!.id);
                    },
                    child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.w, vertical: 20.h),
                        child: categoryProductItem(
                            context: context,
                            txt: '',
                            categoryDetailsCubit: cubit,
                            screenHeight: screenHeight,
                            itemCount:
                                cubit.categoryDetailsModel!.products.length,
                            lst: cubit.categoryDetailsModel!.products))))
            : Scaffold(
                appBar: AppBar(),
                body: categoryDetailsShimmerEffect(screenHeight, screenWidth),
              );
      },
    );
  }
}
