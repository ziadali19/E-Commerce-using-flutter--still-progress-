import 'package:equatable/equatable.dart';

class RegisterModel extends Equatable {
  final String? message;

  final String? status;
  final String? name;
  final String? phone;
  final String? email;
  final String? password;
  final String? confirmPassword;

  const RegisterModel(
      {this.status,
      this.name,
      this.phone,
      this.email,
      this.password,
      this.confirmPassword,
      this.message});
  factory RegisterModel.fromJson(json) {
    return RegisterModel(
      message: json['message'],
      status: json['status'],
    );
  }
  toJson() {
    return {
      'name': name,
      'phone': phone,
      'email': email,
      'password': password,
      'password_confirmation': confirmPassword
    };
  }

  @override
  List<Object?> get props =>
      [message, name, password, confirmPassword, email, phone];
}
