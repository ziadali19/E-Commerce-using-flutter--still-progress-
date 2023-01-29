import 'package:dartz/dartz.dart';
import 'package:e_commerce/features/login/data/repository/login_repository.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/network/failure.dart';
import '../../data/model/login_model.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final BaseLoginRepository baseLoginRepository;
  LoginCubit(this.baseLoginRepository) : super(LoginInitial());
  static LoginCubit get(BuildContext context) {
    return BlocProvider.of(context);
  }

  bool isVisible = false;
  changeVisibilty() {
    isVisible = !isVisible;
    emit(LoginChangeVisibilty());
  }

  LoginModel? model;
  userLogin(String email, String password) async {
    emit(LoginLoading());
    Either<Failure, LoginModel> result =
        await baseLoginRepository.userLogin(email, password);

    result.fold((l) {
      emit(LoginError(l.message));
    }, (r) {
      model = r;
      emit(LoginSuccess());
    });
  }
}
