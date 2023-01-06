import 'package:dartz/dartz.dart';
import 'package:e_commerce/core/network/error_message_model.dart';
import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String? message;

  const Failure(this.message);
  @override
  List<Object?> get props => [message];
}

class NetworkFailure extends Failure {
  const NetworkFailure(super.message);
}

class ApiFailure extends Failure {
  const ApiFailure(super.message);
}
