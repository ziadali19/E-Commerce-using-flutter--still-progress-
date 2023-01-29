import 'package:e_commerce/core/network/dio_helper.dart';
import 'package:e_commerce/core/services/service_locator.dart';
import 'package:e_commerce/core/utilis/cashe_helper.dart';
import 'package:e_commerce/core/utilis/themes.dart';
import 'package:e_commerce/features/categories/controller/cubit/categories_cubit.dart';

import 'package:e_commerce/features/home/controller/cubit/home_cubit.dart';
import 'package:e_commerce/features/home/controller/cubit/home_layout_cubit.dart';
import 'package:e_commerce/features/home/presentation/layouts/home_layout_screen.dart';
import 'package:e_commerce/features/login/presentaions/screens/login_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/utilis/constants.dart';
import 'features/cart/controller/cubit/cart_cubit.dart';
import 'features/categories/controller/cubit/brand_details_cubit.dart';
import 'features/categories/controller/cubit/category_details_cubit.dart';
import 'features/categories/controller/cubit/sub_categories_details_cubit.dart';
import 'features/favorite/controller/cubit/favorite_cubit.dart';

import 'features/filter/controller/cubit/filter_cubit.dart';
import 'features/forget password/controller/cubit/forget_cubit.dart';
import 'features/onboarding/presentation/screens/onboarding_screen.dart';
import 'features/payments/controller/cubit/payments_cubit.dart';
import 'features/product/controller/cubit/products_cubit.dart';
import 'features/search/controller/cubit/search_cubit.dart';
import 'features/settings/controller/cubit/address_cubit.dart';
import 'features/settings/controller/cubit/my_account_cubit.dart';
import 'features/settings/controller/cubit/orders_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ServicesLocator.init();
  initDio();
  initDio1();
  Bloc.observer = MyBlocObserver();
  await CasheHelper.init();
  onBoarding = CasheHelper.getData('onBoarding') as bool?;
  token = CasheHelper.getData('token') as String?;
  debugPrint(token);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) =>
                sl<FavoriteCubit>()..getFavorites(token!, favPageNumber)),
        BlocProvider(
            create: (context) => sl<HomeCubit>()
              ..getActiveUserData(token)
              ..getHomeProducts()
              ..getCategories()),
        BlocProvider(
          create: (context) => HomeLayoutCubit(),
        ),
        BlocProvider(
          create: (context) => sl<CategoriesCubit>()
            ..getCategories()
            ..getSubCategories()
            ..getBrands(),
        ),
        BlocProvider(
          create: (context) => sl<CategoryDetailsCubit>(),
        ),
        BlocProvider(
          create: (context) => sl<ProductsCubit>(),
        ),
        BlocProvider(
          create: (context) => sl<CartCubit>()..getUserCart(token),
        ),
        BlocProvider(create: (context) => sl<SearchCubit>()),
        BlocProvider(create: (context) => sl<ForgetCubit>()),
        BlocProvider(create: (context) => sl<FilterCubit>()..getCategories()),
        BlocProvider(create: (context) => sl<SubCategoriesDetailsCubit>()),
        BlocProvider(create: (context) => sl<BrandDetailsCubit>()),
        BlocProvider(create: (context) => sl<AddressCubit>()),
        BlocProvider(
            create: (context) =>
                sl<MyAccountCubit>()..getActiveUserData(token)),
        BlocProvider(create: (context) => sl<PaymentsCubit>()),
        BlocProvider(create: (context) => sl<OrdersCubit>())
      ],
      child: ScreenUtilInit(
        designSize: const Size(411.42857142857144, 843.4285714285714),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (BuildContext context, Widget? child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            themeMode: ThemeMode.light,
            theme: Themes().lightTheme(),
            home: onBoarding == true
                ? (token != null
                    ? const HomeLayoutScreen()
                    : const LoginScreen())
                : OnBoardingScreen(),
          );
        },
      ),
    );
  }
}
