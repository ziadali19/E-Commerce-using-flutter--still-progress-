import 'package:e_commerce/core/utilis/constants.dart';

import 'package:e_commerce/features/categories/presentaion/components/category_product_item.dart';

import 'package:e_commerce/features/categories/presentaion/components/custom_app_bar.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

import '../../controller/cubit/sub_categories_details_cubit.dart';

import '../components/category_details_shimmer_effect.dart';

class SubCategoryScreen extends StatelessWidget {
  const SubCategoryScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return BlocConsumer<SubCategoriesDetailsCubit, SubCategoriesDetailsState>(
      listener: (context, state) {
        if (state is GetSubCategoryDetailError) {
          AppConstants().showSnackBar(state.error, context, Colors.red);
          Navigator.of(context).pop();
        }
        if (state is AddOrRemoveFavSubCategoryDetailsError) {
          AppConstants().showSnackBar(state.errorMsg, context, Colors.red);
        }
      },
      builder: (context, state) {
        SubCategoriesDetailsCubit cubit =
            SubCategoriesDetailsCubit.get(context);
        return cubit.subCategoryDetailsModel != null
            ? Scaffold(
                appBar:
                    customAppBar(context, cubit.subCategoryDetailsModel!.name!),
                body: LazyLoadScrollView(
                    onEndOfPage: () {
                      cubit.subCategoryMoreData(
                          id: cubit.subCategoryDetailsModel!.subCategoryId);
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: 20.h,
                      ),
                      child: categoryProductItem(
                          context: context,
                          txt: '',
                          subCategoriesDetailsCubit: cubit,
                          screenHeight: screenHeight,
                          itemCount:
                              cubit.subCategoryDetailsModel!.products.length,
                          lst: cubit.subCategoryDetailsModel!.products),
                    )))
            : Scaffold(
                appBar: AppBar(),
                body: categoryDetailsShimmerEffect(screenWidth, screenHeight),
              );
      },
    );
  }
}
/*Navigator.of(context)
    .push(MaterialPageRoute(
  builder: (context) =>
      SubCategoryBrandScreen(
    subCategoryIndex: index,
    subCategoryDetailsModel:
        subCategoryDetailsModel,
  ),
));*/