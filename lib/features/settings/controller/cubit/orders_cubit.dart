import 'package:e_commerce/core/network/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:e_commerce/features/settings/data/model/orders_details_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repository/settings_repository.dart';

part 'orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  final BaseSettingsRepository baseSettingsRepository;
  OrdersCubit(this.baseSettingsRepository) : super(OrdersInitial());
  static OrdersCubit get(context) {
    return BlocProvider.of(context);
  }

  List<OrderDetailsModel> ordersList = [];
  getUserOrders() async {
    emit(GetOrdersLoading());
    Either<Failure, List<OrderDetailsModel>> result =
        await baseSettingsRepository.getUserOrders();
    result.fold((l) {
      emit(GetOrdersError(l.message));
    }, (r) {
      ordersList = r;
      emit(GetOrdersSuccess());
    });
  }
}
