import 'package:dartz/dartz.dart';
import 'package:e_commerce/core/utilis/constants.dart';
import 'package:e_commerce/features/payments/data/model/order_success_model.dart';
import 'package:e_commerce/features/payments/data/repository/payments_repository.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/network/failure.dart';

part 'payments_state.dart';

class PaymentsCubit extends Cubit<PaymentsState> {
  final BasePaymentsRepository basePaymentsRepository;
  PaymentsCubit(this.basePaymentsRepository) : super(PaymentsInitial());
  static PaymentsCubit get(context) {
    return BlocProvider.of(context);
  }

  int groupVal = 1;
  int cash = 1;
  int visa = 2;

  changeGroupVal(value) {
    groupVal = value;
    emit(ChangeGroupValue());
  }

  updateAddress() {
    emit(UpdateAddress());
  }

  OrderSuccessModel? orderSuccessModel;
  makeCheckout(String? paymentType, String? country, String? state,
      String? city, String? addressDetails, String? phone) async {
    orderSuccessModel = null;
    emit(MakeCheckoutLoading());
    Either<Failure, OrderSuccessModel> result = await basePaymentsRepository
        .makeCheckout(paymentType, country, state, city, addressDetails, phone);

    result.fold((l) {
      emit(MakeCheckoutError(l.message));
    }, (r) {
      orderSuccessModel = r;
      emit(MakeCheckoutSuccess());
    });
  }

  paymobGetFirstToken() async {
    emit(GetFirstTokenLoading());
    Either<Failure, String> result =
        await basePaymentsRepository.paymobGetFirstToken();

    result.fold((l) {
      emit(GetFirstTokenError(l.message));
    }, (r) {
      AppConstants.paymobFirstToken = r;
      emit(GetFirstTokenSuccess());
    });
  }

  paymobGetOrderId(String? price, num? merchantOrderId) async {
    emit(GetOrderIdTokenLoading());
    Either<Failure, num> result =
        await basePaymentsRepository.paymobGetOrderId(price, merchantOrderId);

    result.fold((l) {
      emit(GetOrderIdTokenError(l.message));
    }, (r) {
      AppConstants.paymobOrderId = r.toString();
      emit(GetOrderIdTokenSuccess());
    });
  }

  paymobGetFinalToken(String? firstName, String? lastName, String? email,
      String? phone, String? price) async {
    emit(GetFinalTokenLoading());
    Either<Failure, String> result = await basePaymentsRepository
        .paymobGetFinalToken(firstName, lastName, email, phone, price);

    result.fold((l) {
      emit(GetFinalTokenError(l.message));
    }, (r) {
      AppConstants.paymobFinalToken = r;
      emit(GetFinalTokenSuccess());
    });
  }
}
