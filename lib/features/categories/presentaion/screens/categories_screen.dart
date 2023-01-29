import 'package:e_commerce/core/utilis/constants.dart';
import 'package:e_commerce/features/categories/presentaion/components/category_details_shimmer_effect.dart';

import 'package:e_commerce/features/categories/presentaion/components/sub_categories_and_brands_grid_view.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../controller/cubit/categories_cubit.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return BlocConsumer<CategoriesCubit, CategoriesState>(
      listener: (context, state) {
        if (state is GetBrandError) {
          AppConstants().showSnackBar(state.error, context, Colors.red);
          CategoriesCubit.get(context).getBrands();
        }
        if (state is GetCategoryError) {
          AppConstants().showSnackBar(state.error, context, Colors.red);
          CategoriesCubit.get(context).getCategories();
        }
        if (state is GetSubCategoryError) {
          AppConstants().showSnackBar(state.error, context, Colors.red);
          CategoriesCubit.get(context).getSubCategories();
        }
      },
      builder: (context, state) {
        CategoriesCubit cubit = CategoriesCubit.get(context);
        return cubit.brandsList.isNotEmpty &&
                cubit.categoriesList.isNotEmpty &&
                cubit.subCategoriesList.isNotEmpty
            ? ListView(
                children: [
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 15.h, horizontal: 20.w),
                    child: Column(
                      children: [
                        SubCategoriesAndBrandsGridView(
                            header: 'Main Categories',
                            itemCount: cubit.categoriesList.length,
                            lst: cubit.categoriesList),
                        SizedBox(
                          height: screenHeight * 0.029,
                        ),
                        SubCategoriesAndBrandsGridView(
                            header: 'Sub Categories',
                            itemCount: cubit.subCategoriesList.length,
                            lst: cubit.subCategoriesList),
                        SizedBox(
                          height: screenHeight * 0.029,
                        ),
                        SubCategoriesAndBrandsGridView(
                            header: 'Brands',
                            itemCount: cubit.brandsList.length,
                            lst: cubit.brandsList)
                      ],
                    ),
                  ),
                ],
              )
            : categoryDetailsShimmerEffect(screenHeight, screenWidth);
      },
    );
  }
}
/*
 if (state is GetCategorySuccess) {
          return Padding(
            padding: EdgeInsets.all(15.h),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing: 15.h,
                crossAxisSpacing: 15.w,
                crossAxisCount: 2,
              ),
              itemCount: cubit.categoriesList.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  borderRadius: BorderRadius.circular(10.r),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => CategoryDetailsScreen(
                        categoriesCubit: cubit,
                        index: index,
                      ),
                    ));
                    CategoryDetailsCubit.get(context).categoryDetails(
                        cubit.categoriesList[index].data.id,
                        CategoryDetailsCubit.get(context)
                            .categoryDetailspageNumber);
                  },
                  child: SizedBox(
                    height: screenHeight * 0.1,
                    width: screenWidth,
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r)),
                      elevation: 0,
                      margin: EdgeInsets.all(5.sp),
                      color: Colors.grey[300],
                      child: Center(
                          child: Text(
                        cubit.categoriesList[index].data.name!,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w500),
                      )),
                    ),
                  ),
                );
              },
            ),
          );
        } else if (state is GetCategoryError) {
          return AppConstants().showSnackBar(state.error, context, Colors.red);
        } else {
          return categoryShimmerEffect(screenWidth, screenHeight);
        }*/


/*FutureBuilder<List<CategoriesModel>?>(
          future: cubit.getCategories(),
          builder: (BuildContext context,
              AsyncSnapshot<List<CategoriesModel>?> snapshot) {
            if (snapshot.hasData) {
              return ListView.separated(
                itemCount: snapshot.data!.length,
                separatorBuilder: (BuildContext context, int index) {
                  return Container(
                    height: 1.h,
                    width: screenWidth,
                    color: AppConstants.primaryColor,
                  );
                },
                itemBuilder: (BuildContext context, int index) {
                  return ExpansionTile(
                    title: Text(
                      snapshot.data![index].data.name!,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    children: [
                      FutureBuilder<CategoryDetailsModel?>(
                        future: cubit
                            .categoryDetails(snapshot.data![index].data.id),
                        builder: (BuildContext context,
                            AsyncSnapshot<CategoryDetailsModel?> snapshot) {
                          if (snapshot.hasData) {
                            return ListView.builder(
                              shrinkWrap: true,
                              itemCount: snapshot.data!.subCategories.length,
                              itemBuilder: (BuildContext context, int index) {
                                return ExpansionTile(
                                    title: Text(
                                  snapshot.data!.subCategories[index].name!,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black87,
                                      fontSize: 14.sp),
                                ));
                              },
                            );
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(
                                color: AppConstants.primaryColor,
                              ),
                            );
                          }
                        },
                      ),
                    ],
                  );
                },
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(
                  color: AppConstants.primaryColor,
                ),
              );
            }
          },
        );*/