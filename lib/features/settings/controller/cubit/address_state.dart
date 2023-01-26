part of 'address_cubit.dart';

abstract class AddressState {
  const AddressState();
}

class AddressInitial extends AddressState {}

class GetAddressLoading extends AddressState {}

class GetAddressSuccess extends AddressState {}

class GetAddressError extends AddressState {
  final String? errorMsg;

  GetAddressError(this.errorMsg);
}
