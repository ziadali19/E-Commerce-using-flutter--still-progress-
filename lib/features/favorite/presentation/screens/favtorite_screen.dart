import 'package:e_commerce/features/categories/controller/cubit/category_details_cubit.dart';
import 'package:e_commerce/features/favorite/presentation/components/favorite_shimmer_effect.dart';
import 'package:e_commerce/features/home/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

import '../../../../core/utilis/constants.dart';
import '../../../../main.dart';
import '../../../categories/presentaion/components/category_product_item.dart';
import '../../controller/cubit/favorite_cubit.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return BlocConsumer<FavoriteCubit, FavoriteState>(
      listener: (context, state) {
        if (state is GetFavProductsError) {
          AppConstants().showSnackBar(state.errorMsg, context, Colors.red);
        }
      },
      builder: (context, state) {
        FavoriteCubit cubit = FavoriteCubit.get(context);
        return state is GetFavProductsLoading || state is AddOrRemoveFavLoading
            ? favoriteShimmerEffect(screenHeight, screenWidth)
            : cubit.favList.isNotEmpty
                ? LazyLoadScrollView(
                    onEndOfPage: () {
                      cubit.loadMore();
                    },
                    child: ListView(
                      physics: const BouncingScrollPhysics(),
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.w, vertical: 20.h),
                          child: categoryProductItem(
                              favoriteCubit: cubit,
                              txt: '',
                              screenHeight: screenHeight,
                              itemCount: cubit.favList.length,
                              lst: cubit.favList,
                              context: context),
                        ),
                      ],
                    ),
                  )
                : Center(
                    child: Padding(
                      padding: EdgeInsets.all(20.h),
                      child: Text(
                        'Start adding items you love to your wishlist by tapping on the heart icon',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20.sp, fontWeight: FontWeight.w400),
                      ),
                    ),
                  );
      },
    );
  }
}
