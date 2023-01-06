import 'package:bloc/bloc.dart';
import 'package:e_commerce/features/cart/controller/cubit/cart_cubit.dart';
import 'package:e_commerce/features/product/data/models/product_details_model.dart';
import 'package:e_commerce/core/network/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:e_commerce/features/product/data/repository/product_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  final BaseProductRepository baseProductRepository;
  ProductsCubit(this.baseProductRepository) : super(ProductsInitial());
  static ProductsCubit get(BuildContext context) {
    return BlocProvider.of(context);
  }

//
  int productPageNumber = 1;
  ProductDetailsModel? productDetailsModel;
  getProductDetails(int id, int pageNumber) async {
    indicatorIndex = 0;
    pageNumber = 1;
    productDetailsModel = null;
    emit(GetProductDetailsLoading());
    Either<Failure, ProductDetailsModel> result =
        await baseProductRepository.getProductDetails(id, pageNumber);
    result.fold((l) {
      emit(GetProductDetailsError(l.message));
    }, (r) {
      productDetailsModel = r;
      emit(GetProductDetailsSuccess());
    });
  }

  reviewsLoadMore({required int id}) async {
    productPageNumber += 1;
    Either<Failure, ProductDetailsModel> result =
        await baseProductRepository.getProductDetails(id, productPageNumber);
    result.fold((l) {
      emit(GetProductDetailsError(l.message));
    }, (r) {
      if (r.reviews.isNotEmpty) {
        productDetailsModel!.reviews.addAll(r.reviews);

        emit(GetProductDetailsSuccess());
      } else {
        productPageNumber = 1;
      }
    });
  }

  //
  int indicatorIndex = 0;
  changeIndicatorIndex(int index) {
    indicatorIndex = index;
    emit(ChangeIndicatorIndex());
  }

  //add to cart

  addToCart(int productId, String token, context) async {
    emit(AddToCartLoading());
    Either<Failure, String> result =
        await baseProductRepository.addToCart(productId, token);
    result.fold((l) {
      emit(AddToCartError(l.message));
    }, (r) {
      emit(AddToCartSuccess(r));
    });
    if (result.isRight()) {
      CartCubit.get(context).getUserCart(token);
    }
  }
}
