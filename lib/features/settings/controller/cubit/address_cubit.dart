import 'package:bloc/bloc.dart';
import 'package:e_commerce/features/settings/data/model/address_model.dart';
import 'package:e_commerce/core/network/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:e_commerce/features/settings/data/repository/settings_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'address_state.dart';

class AddressCubit extends Cubit<AddressState> {
  final BaseSettingsRepository baseSettingsRepository;
  AddressCubit(this.baseSettingsRepository) : super(AddressInitial());
  static AddressCubit get(context) {
    return BlocProvider.of(context);
  }

  AddressModel? addressModel;
  addAddress(
      String? country, String? state, String? city, String? address) async {
    emit(GetAddressLoading());
    Either<Failure, AddressModel> result =
        await baseSettingsRepository.addAddress(country, state, city, address);
    result.fold((l) {
      emit(GetAddressError(l.message));
    }, (r) {
      addressModel = r;
      emit(GetAddressSuccess());
    });
  }

  getAddress() async {
    emit(GetAddressLoading());
    Either<Failure, AddressModel> result =
        await baseSettingsRepository.getAddress();
    result.fold((l) {
      emit(GetAddressError(l.message));
    }, (r) {
      addressModel = r;
      emit(GetAddressSuccess());
    });
  }
}
