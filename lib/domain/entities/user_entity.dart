import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String profile_picture;

  final String password;

  final String city;
  final String state;
  final String address;

   UserEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
    required this.city,
    required this.state,
    required this.profile_picture,
    required this.address,

  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['profile_picture'] = profile_picture;

    data['password'] = password;
    data['city'] = city;
    data['state'] = state;
    data['address'] = address;

    return data;
  }


  factory UserEntity.fromMap(Map<String, dynamic> json) {
    return UserEntity(
      id: (json.containsKey("id"))? json['id'].toString():"0",

      name: json['name'] as String,
      profile_picture: (json.containsKey("profile_picture"))?json['profile_picture'] as String:"",
      email: json['email'] as String,
      phone: json['phone'] as String,
      city: json['city'] as String,
      state: json['state'] as String,
      address: json['address'] as String,

      password: (json.containsKey("password"))? json['password'] as String:"",
      );
  }

  @override
  String toString() => toJson().toString();
  @override
  List<Object?> get props => [id];
}
