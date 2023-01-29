import 'package:e_commerce/core/utilis/constants.dart';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../controller/cubit/on_boarding_cubit.dart';
import '../../controller/cubit/on_boarding_state.dart';
import '../components/onboarding_app_bar.dart';
import '../components/page_view_column.dart';

class OnBoardingScreen extends StatelessWidget {
  final PageController pageController = PageController();

  OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (context) => OnBoardingCubit(),
      child: Scaffold(
        appBar: onBoardingAppBar(context),
        body: BlocBuilder<OnBoardingCubit, OnBoardingState>(
          builder: (context, state) {
            OnBoardingCubit cubit = OnBoardingCubit.get(context);
            return PageView.builder(
              itemCount: AppConstants.images.length,
              physics: const BouncingScrollPhysics(),
              onPageChanged: (value) {
                cubit.changePage(value);
              },
              controller: pageController,
              itemBuilder: (context, index) {
                return PageViewColumn(
                    index: index,
                    screenWidth: screenWidth,
                    screenHeight: screenHeight,
                    cubit: cubit,
                    pageController: pageController);
              },
            );
          },
        ),
      ),
    );
  }
}
