import 'package:e_commerce/features/cart/data/models/cart_model.dart';
import 'package:e_commerce/core/network/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:e_commerce/features/cart/data/repository/cart_repository.dart';
import 'package:e_commerce/features/payments/controller/cubit/payments_cubit.dart';

import 'package:e_commerce/features/settings/data/model/address_model.dart';
import 'package:e_commerce/features/settings/data/repository/settings_repository.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final BaseCartRepository baseCartRepository;
  final BaseSettingsRepository baseSettingsRepository;
  CartCubit(this.baseCartRepository, this.baseSettingsRepository)
      : super(CartInitial());

  static CartCubit get(BuildContext context) {
    return BlocProvider.of(context);
  }

//
  CartModel? cartModel;
  getUserCart(String? token) async {
    emit(GetUserCartLoading());
    Either<Failure, CartModel> result =
        await baseCartRepository.getUserCart(token);
    result.fold((l) {
      emit(GetUserCartError(l.message));
    }, (r) {
      cartModel = r;
      emit(GetUserCartSuccess());
    });
  }

  //
  deleteItemFromCart(String? token, int itemId) async {
    emit(DeleteItemFromCartLoading());
    Either<Failure, CartModel> result =
        await baseCartRepository.deleteItemFromCart(token, itemId);
    result.fold((l) {
      emit(DeleteItemFromCartError(l.message));
    }, (r) {
      cartModel = r;
      emit(DeleteItemFromCartSuccess());
    });
    /*if (result.isRight()) {
      getUserCart(token);
    }*/
  }

  //
  updateItemAmount(String? token, int itemId, int count) async {
    emit(UpdateItemAmountLoading());
    Either<Failure, CartModel> result =
        await baseCartRepository.updateItemAmount(token, itemId, count);
    result.fold((l) {
      emit(UpdateItemAmountError(l.message));
    }, (r) {
      cartModel = r;
      emit(UpdateItemAmountSuccess());
    });
    /*if (result.isRight()) {
      getUserCart(token);
    }*/
  }

  AddressModel? addressModel;
  getAddress(context) async {
    emit(GetAddressCartLoading());
    Either<Failure, AddressModel> result =
        await baseSettingsRepository.getAddress();
    result.fold((l) {
      emit(GetAddressCartError(l.message));
    }, (r) {
      addressModel = r;
      emit(GetAddressCartSuccess());
      PaymentsCubit.get(context).updateAddress();
    });
  }
}
