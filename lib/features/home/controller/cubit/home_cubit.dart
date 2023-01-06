import 'package:bloc/bloc.dart';
import 'package:e_commerce/features/home/data/model/active_user_model.dart';
import 'package:e_commerce/core/network/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:e_commerce/features/home/data/model/categories_model.dart';
import 'package:e_commerce/features/home/data/model/product_details_model.dart';
import 'package:e_commerce/features/home/data/repository/home_repository.dart';
import 'package:e_commerce/features/home/presentation/layouts/home_layout_screen.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../presentation/screens/home_screen.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.homeBaseRepository) : super(HomeInitial());
  final HomeBaseRepository homeBaseRepository;
  static HomeCubit get(context) {
    return BlocProvider.of(context);
  }

//getActiveUserData
  ActiveUserModel? userModel;
  getActiveUserData(token) async {
    emit(HomeGetActiveUserDataLoading());
    Either<Failure, ActiveUserModel> result =
        await homeBaseRepository.getActiveUserData(token);
    result.fold((l) {
      emit(HomeGetActiveUserDataError(l.message));
    }, (r) {
      userModel = r;
      emit(HomeGetActiveUserDataSuccess());
    });
  }

//get products

  List<ProductsDataModel> products = [];

  getProducts(int pageNumber) async {
    products = [];
    emit(HomeGetProductsLoading());
    Either<Failure, List<ProductsDataModel>> result =
        await homeBaseRepository.getProducts(pageNumber);
    result.fold((l) {
      emit(HomeGetProductsError(l.message));
    }, (r) {
      products = r;

      emit(HomeGetProductsSuccess());
    });
  }

  //get categories
  List<CategoriesDataModel> categories = [];
  getCategories() async {
    emit(HomeGetCategoriesLoading());
    Either<Failure, List<CategoriesDataModel>> result =
        await homeBaseRepository.getCategories();
    result.fold((l) {
      emit(HomeGetCategoriesError(l.message));
    }, (r) {
      categories = r;
      emit(HomeGetCategoriesSuccess());
    });
  }
}
