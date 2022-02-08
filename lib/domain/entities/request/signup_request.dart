class SignupRequestParams{
  final String email;
  final String name;
  final String password;
  final String dob;
  final String phone;
  final String time_zone_offset;
  final String time_zone;
  final String user_country;
  final String user_country_code;
  final String ip;
  final String dumm_msg;

  SignupRequestParams({
    required this.name,
    required this.dob,
    required this.email,
    required this.password,
    required this.phone,
    required this.time_zone_offset,
    required this.time_zone,
    required this.user_country,
    required this.user_country_code,
    required this.ip,
    required this.dumm_msg,
  });

  Map<String, dynamic> toJson() => {
    'email': email,
    'name': name,
    'password': password,
    'dob': dob,
    'phone': phone,
    'time_zone': time_zone,
    'user_country': user_country,
    'user_country_code': user_country_code,
    'ip': ip,
    'dumm_msg': dumm_msg,
    'time_zone_offset': time_zone_offset
  };
}