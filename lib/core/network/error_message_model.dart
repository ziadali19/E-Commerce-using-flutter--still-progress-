import 'package:equatable/equatable.dart';

class ErrorModel extends Equatable {
  final String? errorMessage;

  const ErrorModel({required this.errorMessage});

  factory ErrorModel.fromJson(json) {
    return ErrorModel(errorMessage: json['message']['email'][0]);
  }

  @override
  List<String?> get props => [errorMessage];
}
