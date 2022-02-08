class ServiceModel {
  String id;
  String name;
  String image;
  String description;
  String cost;
  String duration;
  String service_type;
  String status;
  ServiceModel({required this.id,required this.name,required this.description,required this.status,
    required this.image,required this.cost,required this.duration,required this.service_type,});

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      id: json['id'] as String,
      name: json['name'] as String,
      image: json['image'] as String,
      description: json['description'] as String,
      cost: json['cost'] as String,
      duration: json['duration'] as String,
      service_type: json['service_type'] as String,
      status: json['status'] as String,

    );
  }

   static parseList(dynamic json) {

    List<ServiceModel>serviceList=List.empty(growable: true);

    json.forEach(( value) {
      serviceList.add(ServiceModel.fromJson(value));
    });

    return serviceList;
  }


}