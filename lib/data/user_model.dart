



import 'package:pet_groom/domain/entities/user_entity.dart';

class UserModel extends UserEntity{
  final String id;
  final String name;
  final String email;
  final String phone;
  final String profile_picture;
  final String password;
  final String city;
  final String state;
  final String address;
   UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.profile_picture,
    required this.password, required this.city,
     required this.state,
     required this.address,
  }) : super(
    id: id,
    name: name,
    email: email,
    phone: phone,
    city:city,
    password: password,
    state: state,
    address: address,
     profile_picture: profile_picture,

  );

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['data']['id'] as String,
      profile_picture: (json['data'].containsKey("profile_picture"))?json['data']['profile_picture'] as String:"",
      name: json['data']['name'] as String,
      email: json['data']['email'] as String,
      phone: json['data']['phone'] as String,
      password: json['data']['password'] as String,
      city: json['city'] as String,
      state: json['state'] as String,
      address: json['address'] as String,
    );
  }



  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['password'] = password;
    data['phone'] = phone;
    data['city'] = city;
    data['state'] = state;
    data['address'] = address;
    return data;
  }

  @override
  String toString() => toJson().toString();


}