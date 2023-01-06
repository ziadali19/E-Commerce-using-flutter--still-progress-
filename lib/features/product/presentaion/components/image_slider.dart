import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../controller/cubit/products_cubit.dart';

class ImageSlider extends StatelessWidget {
  const ImageSlider({
    Key? key,
    required this.cubit,
    required this.screenHeight,
    required this.screenWidth,
  }) : super(key: key);

  final ProductsCubit cubit;
  final double screenHeight;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: cubit.productDetailsModel!.gallery.length,
      options: CarouselOptions(
        height: screenHeight * 0.5,
        initialPage: 0,
        enableInfiniteScroll: true,
        reverse: false,
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: true,
        enlargeFactor: 0.3,
        scrollDirection: Axis.horizontal,
        onPageChanged: (index, reason) {
          cubit.changeIndicatorIndex(index);
        },
      ),
      itemBuilder: (context, index, realIndex) {
        return Container(
          width: screenWidth,
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: cubit.productDetailsModel!.gallery.isNotEmpty
                      ? NetworkImage(
                          cubit.productDetailsModel!.gallery[index].image!)
                      : NetworkImage(
                          cubit.productDetailsModel!.productImage!))),
        );
      },
    );
  }
}
