
class EventRequestParams{

  final String id;
  final String event_id;
  final String user_country_code;


  EventRequestParams({
    required this.id,
    required this.event_id,
    required this.user_country_code
  });

  Map<String, dynamic> toJson() => {
    'event': event_id,
    'uid': id,
    'user_country_code': user_country_code,
  };
}


class JoinEventParams{

  final String gid;
  final String uid;
  final String longitude;
  final String latitude;


  JoinEventParams({
    required this.gid ,
    required this.uid,
    required this.longitude,
    required this.latitude
  });

  Map<String, dynamic> toJson() => {
    'gid': gid,
    'uid': uid,
    'longitude': longitude,
    'latitude': latitude
  };
}