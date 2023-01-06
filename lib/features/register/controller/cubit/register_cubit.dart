import 'package:e_commerce/features/register/data/model/register_model.dart';
import 'package:e_commerce/core/network/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:e_commerce/features/register/data/repository/register_remote_data_repository.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final BaseRegisterRepository baseRegisterRepository;
  RegisterCubit(this.baseRegisterRepository) : super(RegisterInitial());
  static RegisterCubit get(BuildContext context) {
    return BlocProvider.of(context);
  }

  bool isVisible = false;
  changeVisibilty() {
    isVisible = !isVisible;
    emit(RegisterChangeVisibilty());
  }

  RegisterModel? model;
  createUser(String email, String password, String confirmPassword,
      String phone, String name) async {
    emit(RegisterLoading());
    Either<Failure, RegisterModel> result = await baseRegisterRepository
        .createUser(email, password, confirmPassword, phone, name);

    result.fold((l) {
      emit(RegisterError(l.message));
    }, (r) {
      model = r;
      emit(RegisterSuccess());
    });
  }
}
