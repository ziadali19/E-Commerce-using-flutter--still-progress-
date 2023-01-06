import 'error_message_model.dart';

class ApiException implements Exception {
  final ErrorModel errorModel;
  const ApiException({required this.errorModel});
}

class NetworkException implements Exception {
  final String? message;

  NetworkException({required this.message});
}
