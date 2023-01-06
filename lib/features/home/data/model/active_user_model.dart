import 'package:equatable/equatable.dart';

class ActiveUserModel extends Equatable {
  final String? userType;
  final ActiveUserDataModel data;

  const ActiveUserModel({required this.userType, required this.data});

  factory ActiveUserModel.fromJson(json) {
    return ActiveUserModel(
      userType: json['user_type'],
      data: ActiveUserDataModel.fromJson(json['data']),
    );
  }

  @override
  List<Object?> get props => [userType, data];
}

class ActiveUserDataModel extends Equatable {
  final dynamic id;
  final String? name;
  final String? email;
  final String? phone;

  const ActiveUserDataModel(
      {required this.id,
      required this.name,
      required this.email,
      required this.phone});

  factory ActiveUserDataModel.fromJson(json) {
    return ActiveUserDataModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
    );
  }

  @override
  List<Object?> get props => [id, name, email, phone];
}
