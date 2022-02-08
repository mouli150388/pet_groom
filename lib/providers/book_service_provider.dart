
import 'package:flutter/cupertino.dart';
import 'package:pet_groom/data/service_model.dart';

class BookserviceProvider extends ChangeNotifier{
  List<ServiceModel>serviceIds;
  String? timeslot;
  String? date;
  BookserviceProvider(this.serviceIds);

  addService(ServiceModel serviceModel)
  {
    if(checkServiceId(serviceModel.id))
     {
       removeService(serviceModel.id);
       return;
     }
    serviceIds.add(serviceModel);
    notifyListeners();
  }

  removeService(String id)
  {
    print("Ids Remove ${id}");
    int pos=-1;
    serviceIds.forEach((element) {
      if(element.id==id)
        pos=serviceIds.indexOf(element);
    });
    print("Ids Remove  ${id} pos ${pos}");
    if(serviceIds.length>pos)
    serviceIds.removeAt(pos);
    notifyListeners();
  }

  checkServiceId(String id)
  {
    print("Ids checke service ${id} ");
    bool isContians=false;
    serviceIds.forEach((element) {
      if(element.id==id)
        isContians= true;
    });
    print("Ids checke service ${id} pos ${isContians}");
    return isContians;
  }

  getCount()
  {
    return serviceIds.length;
  }
  getTotalPrice()
  {
    num total=0;
    serviceIds.forEach((element) {
      total=total+num.parse(element.cost);
    });
    return total;
  }
  getTotalTime()
  {
    num total=0;
    serviceIds.forEach((element) {
      total=total+num.parse(element.cost.replaceAll(" min", ""));
    });
    return total;
  }

  clear()
  {
    serviceIds.clear();
    timeslot=null;
    date=null;
    notifyListeners();
  }

  getIds()
  {
    String id="";
    String services_name="";
    List<String>params=List.empty(growable: true);
    serviceIds.forEach((element) {
      id=id+element.id+",";
      services_name=services_name+element.name+",";
    });
    if(id.endsWith(","))
     id=id.substring(0,id.lastIndexOf(",")) ;
    if(services_name.endsWith(","))
      services_name=services_name.substring(0,services_name.lastIndexOf(",")) ;

    params.add(id);
    params.add(services_name);
    return params;
  }
}