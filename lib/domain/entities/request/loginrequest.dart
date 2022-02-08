
class LoginRequestParams{

  final String email;
  final String password;
  final String phone;


  LoginRequestParams({
    required this.email,
    required this.password,
    required this.phone
  });

  Map<String, dynamic> toJson() => {
    'email': email,
    'password': password,
    'phone': phone
  };
}