import 'package:equatable/equatable.dart';

class LoginModel extends Equatable {
  final String? accessToken;
  final DataModel data;

  const LoginModel({required this.accessToken, required this.data});

  factory LoginModel.fromJson(json) {
    return LoginModel(
      accessToken: json['access_token'],
      data: DataModel.fromJson(json['data']),
    );
  }

  @override
  List<Object?> get props => [accessToken, data];
}

class DataModel extends Equatable {
  final dynamic id;
  final String? name;
  final String? email;
  final String? phone;

  const DataModel(
      {required this.id,
      required this.name,
      required this.email,
      required this.phone});

  factory DataModel.fromJson(json) {
    return DataModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
    );
  }

  @override
  List<Object?> get props => [id, name, email, phone];
}
