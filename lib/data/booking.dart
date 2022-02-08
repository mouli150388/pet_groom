class Booking {
  String id;
  String services_name;
  String booking_date;
  String booking_time;
  String person="Assigned To Kiran";
  num total_cost=180;
  int status=0;
  String description="";
  Booking({required this.id,required  this.services_name,required  this.booking_time,required  this.booking_date,
     this.person="", this.description="",required this.total_cost,required this.status});


  factory Booking.fromJson(Map<String, dynamic> json) {

    return Booking(
        id: json['id'] as String,
      services_name: (json['services_name']==null)?"":json['services_name'] as String,
        booking_time: json['booking_time'] as String,
        booking_date: json['booking_date'] as String,
        status: int.parse(json['status'] as String) ,
      total_cost: num.parse(json['total_cost'] as String),



    );
  }
}