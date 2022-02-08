class PetModel{
  String id;
  String pet_name;
  String pet_age;
  String pet_sex;
  String pet_breed;
  String pet_size;
  String pet_type;
  PetModel({required this.id,required this.pet_name,required this.pet_age,required this.pet_sex,
    required this.pet_breed,required this.pet_size,required this.pet_type});

  factory PetModel.fromJson(Map<String, dynamic> json) {

    return PetModel(
        id: json['id'] as String,
        pet_name: json['pet_name'] as String,
        pet_age: json['pet_age'] as String,
        pet_sex: json['pet_sex'] as String,
      pet_breed: json['pet_breed'] as String,
      pet_type: json['pet_type'] as String,
      pet_size: json['pet_size'] as String,



    );
  }
}