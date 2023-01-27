import 'package:bloc/bloc.dart';
import 'package:e_commerce/core/network/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:e_commerce/features/settings/data/repository/settings_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'my_account_state.dart';

class MyAccountCubit extends Cubit<MyAccountState> {
  final BaseSettingsRepository baseSettingsRepository;
  MyAccountCubit(this.baseSettingsRepository) : super(MyAccountInitial());
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
}
