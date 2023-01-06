part of 'forget_cubit.dart';

abstract class ForgetState extends Equatable {
  const ForgetState();
}

class ForgetInitial extends ForgetState {
  @override
  List<Object?> get props => [];
}

class ForgetLoading extends ForgetState {
  @override
  List<Object?> get props => [];
}

class ForgetSuccess extends ForgetState {
  @override
  List<Object?> get props => [];
}

class ForgetError extends ForgetState {
  final String? errorMsg;

  const ForgetError(this.errorMsg);
  @override
  List<Object?> get props => [];
}
