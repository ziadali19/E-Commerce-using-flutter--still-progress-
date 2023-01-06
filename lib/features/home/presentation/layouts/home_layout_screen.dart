import 'package:e_commerce/core/utilis/constants.dart';
import 'package:e_commerce/features/favorite/controller/cubit/favorite_cubit.dart';
import 'package:e_commerce/features/home/controller/cubit/home_cubit.dart';
import 'package:e_commerce/features/login/presentaions/screens/login_screen.dart';
import 'package:e_commerce/features/search/presentaion/screens/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../main.dart';
import '../../controller/cubit/home_layout_cubit.dart';
import '../components/home_layout_appbar.dart';

class HomeLayoutScreen extends StatelessWidget {
  const HomeLayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeLayoutCubit, HomeLayoutState>(
      builder: (context, state) {
        HomeLayoutCubit cubit = HomeLayoutCubit.get(context);
        return Scaffold(
          appBar: homeLayoutAppBar(cubit, context),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            items: [
              BottomNavigationBarItem(
                  activeIcon: SvgPicture.asset(
                    'assets/images/Home.svg',
                    color: AppConstants.primaryColor,
                  ),
                  label: 'Home',
                  icon: SvgPicture.asset('assets/images/Home.svg')),
              BottomNavigationBarItem(
                  activeIcon: SvgPicture.asset(
                    'assets/images/grid.svg',
                    color: AppConstants.primaryColor,
                  ),
                  label: 'Categories',
                  icon: SvgPicture.asset('assets/images/grid.svg')),
              BottomNavigationBarItem(
                  activeIcon: SvgPicture.asset(
                    'assets/images/favorite.svg',
                    color: AppConstants.primaryColor,
                  ),
                  label: 'Favorites',
                  icon: SvgPicture.asset('assets/images/favorite.svg')),
              BottomNavigationBarItem(
                  activeIcon: SvgPicture.asset(
                    'assets/images/cart.svg',
                    color: AppConstants.primaryColor,
                  ),
                  label: 'Cart',
                  icon: SvgPicture.asset('assets/images/cart.svg')),
              BottomNavigationBarItem(
                  activeIcon: SvgPicture.asset(
                    'assets/images/user.svg',
                    color: AppConstants.primaryColor,
                  ),
                  label: 'My Account',
                  icon: SvgPicture.asset('assets/images/user.svg'))
            ],
            onTap: (value) {
              cubit.navBar(value);
            },
            currentIndex: cubit.currentIndex,
          ),
        );
      },
    );
  }
}
