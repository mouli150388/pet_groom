import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pet_groom/core/api/api_client.dart';
import 'package:pet_groom/core/api/api_constants.dart';
import 'package:pet_groom/core/screen_utils.dart';
import 'package:pet_groom/di/dependency_injection.dart';
import 'package:pet_groom/domain/entities/response_entity.dart';
import 'package:pet_groom/providers/book_service_provider.dart';
import 'package:pet_groom/data/slot_model.dart';
import 'package:pet_groom/screens/widgets/loading_circle.dart';
import 'package:pet_groom/shared/app_colors.dart';
import 'package:pet_groom/shared/button_widget.dart';
import 'package:pet_groom/shared/header_text.dart';
import 'package:table_calendar/table_calendar.dart';

import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class BookingScreen extends StatefulWidget{
  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  late DateTime date;
  var selectedDate;
  var selected_time="";
   double itemHeight=0;
   double itemWidth=0;
   bool isLoading=false;
   List<TimeSlot>timeSlot=List.empty(growable:true );
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     date= selectedDate=DateTime.now();
   getTimeSlots();
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    itemHeight = 20.h;
    itemWidth = size.width / 3;
    return Scaffold(
      backgroundColor: AppColor.scaffoldColor,
      appBar: AppBar(
        leading: InkWell(child: Icon(Icons.arrow_back_ios,color: Colors.black,),onTap: (){
          Navigator.pop(context);
        },),
        title: Center(child: Text("${AppLocalizations.of(context)?.booking}",style: TextStyle(color: Colors.black),)),backgroundColor: Colors.white,elevation: 0,),
      body: ListView(
        children: [
              TableCalendar(
              firstDay: DateTime.utc(date.year, date.month, date.day),
              lastDay: DateTime.utc(date.year+1),
              selectedDayPredicate: (day){
                return selectedDate==day;
              },
              focusedDay: selectedDate,
                onDaySelected: (selectedDay,focusday){

                setState(() {
                  selectedDate=selectedDay;
                  getTimeSlots();
                });

                },
            ),
          SizedBox(height:5,),
          Divider(thickness: 1,color: Colors.grey,),
          SizedBox(height:5,),
          HeaderText(text:"${AppLocalizations.of(context)?.choose_time}"),
          (isLoading)
              ? Center(
            child: CircularProgressIndicator(),
          )
              : SizedBox.shrink(),
          (timeSlot.length>0)?GridView.builder(
            shrinkWrap: true,
            itemCount: timeSlot.length,
            itemBuilder: (context,index){
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextButton(
                  style: ButtonStyle(
                    shape:  MaterialStateProperty.all<OutlinedBorder>(
                        RoundedRectangleBorder(
                          side:BorderSide(color: AppColor.black,width: 2),
                          borderRadius: BorderRadius.all(
                            Radius.circular(2.0),

                          ),
                        )),
                      backgroundColor:(timeSlot[index].isBooked)?MaterialStateProperty.all(AppColor.grey):(timeSlot[index].checked)? MaterialStateProperty.all(AppColor.btn_color): MaterialStateProperty.all(AppColor.white)),
                    onPressed: (){
                    if(timeSlot[index].isBooked)
                      {
                        Fluttertoast.showToast(msg:"This slot not available", toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: AppColor.pink,
                            textColor: Colors.white,
                            fontSize: 16.0);
                        return;
                      }
                    setState(() {
                      timeSlot.forEach((element) {
                        element.checked=false;
                      });

                      timeSlot[index].checked=true;
                      selected_time=timeSlot[index].time;
                    });
                    }, child: Text("${timeSlot[index].time}:00",style: TextStyle(
                  color: timeSlot[index].checked?Colors.white:Colors.black,
                ),)),
              );
            }, gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,childAspectRatio:(itemWidth / itemHeight)),
          ):Center(
            child: Text("No Time Slots available",style: TextStyle(fontSize: 20,color: Colors.black),),
          ),
          SizedBox(height: 20,),
          Consumer<BookserviceProvider>(builder: (context,service,child)=> AppPrimaryButton(onPress: (){

            if(selected_time.isEmpty)
              {
                Fluttertoast.showToast(msg: "Please select available Timeslot", toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: AppColor.pink,
                    textColor: Colors.white,
                    fontSize: 16.0);

                return;
              }
           String day=(selectedDate.day.toString().length>1)?selectedDate.day.toString():"0${selectedDate.day}";
           String month=(selectedDate.month.toString().length>1)?selectedDate.month.toString():"0${selectedDate.month}";

           service.date="${month}/${day}/${selectedDate.year}";
            service.timeslot=selected_time;
              Navigator.pushReplacementNamed(context, "/bookingSummary");
            //Navigator.pop(context);
            },text: "${AppLocalizations.of(context)?.book_appointment}",
            width: 300.w,),
          ),
          SizedBox(height: 20,),
        ],
      ),
    );
  }

  getTimeSlots()async
  {
    setState(() {
      isLoading=true;
      timeSlot.clear();
    });

    ApiClient api=getItInstance();
    Map<String,String>params=Map();
    String s;
    int d;

    String day=(selectedDate.day.toString().length>1)?selectedDate.day.toString():"0${selectedDate.day}";
    String month=(selectedDate.month.toString().length>1)?selectedDate.month.toString():"0${selectedDate.month}";
    params['date']="${month}/${day}/${selectedDate.year}";
    var response= await api.post(ApiConstants.time_slots,body: params,fakeData: false );
    ApiResponse apiResposne=ApiResponse.fromMap(response);

    //Fluttertoast.showToast(msg: apiResposne.msg);

    if(apiResposne.code=='5')
    {
      TimeSlotReponse timeSlotReponse=TimeSlotReponse.fromJson(apiResposne.data);


     /* var list=ServiceModel.parseList(apiResposne.data) as List<ServiceModel>;
      list.forEach((element) {
        if(element.service_type=="main")
          serviceList.add(element);
        else if(element.service_type=="ad_on")
          adonserviceList.add(element);
      });*/

      setState(() {
        isLoading=false;
        timeSlot.clear();
        timeSlot.addAll(timeSlotReponse.timeSlots);
      });


      return;
    }
    setState(() {
      isLoading=false;
    });
    /*Fluttertoast.showToast(msg: apiResposne.msg, toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: AppColor.pink,
        textColor: Colors.white,
        fontSize: 16.0);*/
  }
}