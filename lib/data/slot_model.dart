class TimeSlot{
  String time;
  bool isBooked;
  bool checked;
  TimeSlot({required this.isBooked,required this.time,required this.checked});


}
class TimeSlotReponse{
  String id;
  String service_date;
  String time_slot;
  String booked;
  List<TimeSlot>timeSlots;
  TimeSlotReponse({required this.id,required this.service_date,required this.time_slot,required this.booked,
  required this.timeSlots});

  factory TimeSlotReponse.fromJson(Map<String, dynamic> json) {

    return TimeSlotReponse(
      id: json['id'] as String,
      service_date: json['service_date'] as String,
      time_slot: json['time_slot'] as String,
      booked: json['booked'] as String,
        timeSlots:getSlots(json['time_slot']as String,json['booked'] as String)


    );
  }

  static getSlots(String time_slots,String book_slots)
  {
    List<TimeSlot>listTimeSlots=List.empty(growable: true);
    List<String> listTime= time_slots.split(',');
    List<String> listBook = book_slots.split(',');
    listTime.forEach((element) {
    bool isBooked=false;
    print("Time slots booked ${element} ");
      if(listBook.contains(element))
        {
          isBooked=true;
          print("Time slots booked ${element} ${isBooked}");
        }
    listTimeSlots.add(TimeSlot(time: element,checked: false,isBooked: isBooked));
    });

    return listTimeSlots;
  }
}


