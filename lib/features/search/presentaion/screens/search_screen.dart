import 'package:e_commerce/core/common/text_field.dart';
import 'package:e_commerce/core/utilis/constants.dart';
import 'package:e_commerce/features/categories/presentaion/components/category_product_item.dart';
import 'package:e_commerce/features/categories/presentaion/components/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

import '../../controller/cubit/search_cubit.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return BlocConsumer<SearchCubit, SearchState>(
      listener: (context, state) {
        if (state is SearchProductsError) {
          AppConstants().showSnackBar(state.errorMsg, context, Colors.red);
        }
      },
      builder: (context, state) {
        SearchCubit cubit = SearchCubit.get(context);
        return Scaffold(
          appBar: customAppBar(context, 'Search'),
          body: LazyLoadScrollView(
            onEndOfPage: () {
              cubit.searchLoadMore(keyWord: cubit.searchController.text);
            },
            child: ListView(children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20.w,
                  vertical: 20.h,
                ),
                child: Column(
                  children: [
                    CustomTextField(
                      searchCubit: cubit,
                      controller: cubit.searchController,
                      hintText: 'What are you looking for?',
                      textInputType: TextInputType.text,
                      assetName: 'assets/images/Search.svg',
                    ),
                    SizedBox(height: 10.h),
                    state is SearchProductsLoading
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : cubit.searchList.isNotEmpty
                            ? categoryProductItem(
                                context: context,
                                txt: '',
                                searchCubit: cubit,
                                screenHeight: screenHeight,
                                itemCount: cubit.searchList.length,
                                lst: cubit.searchList)
                            : const SizedBox()
                  ],
                ),
              ),
            ]),
          ),
        );
      },
    );
  }
}
