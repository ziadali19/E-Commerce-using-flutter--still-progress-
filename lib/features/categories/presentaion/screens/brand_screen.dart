import 'package:e_commerce/features/categories/presentaion/components/category_product_item.dart';
import 'package:e_commerce/features/categories/presentaion/components/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

import '../../../../core/utilis/constants.dart';
import '../../controller/cubit/brand_details_cubit.dart';

import '../components/category_details_shimmer_effect.dart';

class BrandScreen extends StatelessWidget {
  const BrandScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return BlocConsumer<BrandDetailsCubit, BrandDetailsState>(
      listener: (context, state) {
        if (state is GetBrandDetailError) {
          AppConstants().showSnackBar(state.error, context, Colors.red);
          Navigator.of(context).pop();
        }
        if (state is AddOrRemoveFavBrandError) {
          AppConstants().showSnackBar(state.errorMsg, context, Colors.red);
        }
      },
      builder: (context, state) {
        BrandDetailsCubit cubit = BrandDetailsCubit.get(context);
        return cubit.brandDetailsModel != null
            ? Scaffold(
                appBar: customAppBar(context, cubit.brandDetailsModel!.name!),
                body: LazyLoadScrollView(
                    onEndOfPage: () {
                      cubit.brandMoreData(id: cubit.brandDetailsModel!.id);
                    },
                    child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.w, vertical: 20.h),
                        child: categoryProductItem(
                            context: context,
                            txt: '',
                            screenHeight: screenHeight,
                            brandDetailsCubit: cubit,
                            itemCount: cubit.brandDetailsModel!.products.length,
                            lst: cubit.brandDetailsModel!.products))))
            : Scaffold(
                appBar: AppBar(),
                body: categoryDetailsShimmerEffect(screenWidth, screenHeight),
              );
      },
    );
  }
}
