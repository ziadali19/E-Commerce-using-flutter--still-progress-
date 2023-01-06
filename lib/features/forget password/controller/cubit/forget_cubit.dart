import 'package:bloc/bloc.dart';
import 'package:e_commerce/core/network/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:e_commerce/features/forget%20password/data/repository/forget_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'forget_state.dart';

class ForgetCubit extends Cubit<ForgetState> {
  final BaseForgetRepository baseForgetRepository;
  ForgetCubit(this.baseForgetRepository) : super(ForgetInitial());
  static ForgetCubit get(BuildContext context) {
    return BlocProvider.of(context);
  }

  String successMsg = '';
  forgetPassword(String email) async {
    emit(ForgetLoading());
    Either<Failure, String> result =
        await baseForgetRepository.forgetPassword(email);

    result.fold((l) {
      emit(ForgetError(l.message));
    }, (r) {
      successMsg = r;
      emit(ForgetSuccess());
    });
  }
}
