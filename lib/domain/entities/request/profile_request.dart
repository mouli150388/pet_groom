class ProfileRequestParams{
  final String id;
  final String name;
  final String phone;
  final String email;


  ProfileRequestParams({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'phone': phone,
    'email': email,
  };
}