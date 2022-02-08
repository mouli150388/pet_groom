
class EventRequestDetailsParams{


  final String id;
  final String event_id;


  EventRequestDetailsParams({
    required this.id,
    required this.event_id
  });

  Map<String, dynamic> toJson() => {
    'uid': id,
    'id': event_id,
    'gid': event_id,
  };
}


class EventJoinRequestParams{


  final String id;
  final String event_id;
  final String amount;
  final String status;
  final String txnid;
  final String orderid;


  EventJoinRequestParams({
    required this.id,
    required this.event_id,
    required this.amount,
    required this.status,
    required this.orderid,
    required this.txnid,
  });

  Map<String, dynamic> toJson() => {
    'uid': id,
    'id': event_id,
    'gid': event_id,
    'amount': amount,
    'status': status,
    'txnid': txnid,
    'orderid': orderid,
  };
}