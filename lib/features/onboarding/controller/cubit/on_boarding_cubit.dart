import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'on_boarding_state.dart';

class OnBoardingCubit extends Cubit<OnBoardingState> {
  OnBoardingCubit() : super(OnBoardingInitial());

  static OnBoardingCubit get(BuildContext context) {
    return BlocProvider.of(context);
  }

  int pageIndex = 0;
  changePage(value) {
    pageIndex = value;
    emit(OnBoardingChangePageState());
  }
}
