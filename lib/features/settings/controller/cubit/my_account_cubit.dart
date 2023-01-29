import 'package:e_commerce/core/network/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:e_commerce/features/home/data/repository/home_repository.dart';
import 'package:e_commerce/features/settings/data/repository/settings_repository.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../home/data/model/active_user_model.dart';

part 'my_account_state.dart';

class MyAccountCubit extends Cubit<MyAccountState> {
  final BaseSettingsRepository baseSettingsRepository;
  final HomeBaseRepository homeBaseRepository;
  MyAccountCubit(this.baseSettingsRepository, this.homeBaseRepository)
      : super(MyAccountInitial());
  static MyAccountCubit get(context) {
    return BlocProvider.of(context);
  }

  userLogOut() async {
    emit(UserLogOutLoading());
    Either<Failure, String> result = await baseSettingsRepository.userLogOut();
    result.fold((l) {
      emit(UserLogOutError(l.message));
    }, (r) {
      emit(UserLogOutSuccess());
    });
  }

  //getActiveUserData
  ActiveUserModel? userModel;
  getActiveUserData(token) async {
    emit(MyAccountGetActiveUserDataLoading());
    Either<Failure, ActiveUserModel> result =
        await homeBaseRepository.getActiveUserData(token);
    result.fold((l) {
      emit(MyAccountGetActiveUserDataError(l.message));
    }, (r) {
      userModel = r;
      emit(MyAccountGetActiveUserDataSuccess());
    });
  }
}
