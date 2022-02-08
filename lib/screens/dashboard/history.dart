import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pet_groom/core/api/api_client.dart';
import 'package:pet_groom/core/api/api_constants.dart';
import 'package:pet_groom/data/booking.dart';
import 'package:pet_groom/di/dependency_injection.dart';
import 'package:pet_groom/domain/entities/response_entity.dart';
import 'package:pet_groom/screens/dashboard/widgets/mybooking_widget.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pet_groom/shared/app_colors.dart';

import 'booking_details.dart';
class HistoryScreen extends StatefulWidget{
  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  bool isLoading=false;
  List<Booking>myBookingsList=List.empty(growable: true);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMyBooks();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColor.scaffoldColor,
      appBar: AppBar(title: Text("${AppLocalizations.of(context)?.booking}S",style: TextStyle(color: AppColor.black),),backgroundColor: AppColor.scaffoldColor,),
      body:(myBookingsList.length<=0)?Center(
        child: Text("No data available",style: TextStyle(fontSize: 20,color: Colors.black),),
      ):(isLoading)? Center(child:CircularProgressIndicator()):ListView.builder(
          itemCount: myBookingsList.length,
          itemBuilder: (context,index){
            var myBooking=myBookingsList[index];
        return InkWell(
          onTap: ()async {
            var response=await Navigator.push(
                context, MaterialPageRoute(builder: (ctx){
              return MyBookingDetails(myBooking);
            }));
            if(response!=null&&response==1)
              getMyBooks();
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("#${myBooking.id}",style: TextStyle(fontWeight: FontWeight.bold),),
                              Text("${myBooking.services_name} "),
                            ],
                          ),
                        ),
                        getStatusWidget(myBooking)

                      ],),

                    SizedBox(height: 4,),


                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("${myBooking.booking_date} ${myBooking.booking_time}:00",style: TextStyle(fontSize: 12,color: Colors.grey,fontWeight: FontWeight.w100),),
                        Text("\$${myBooking.total_cost}",style: TextStyle(fontWeight: FontWeight.bold),),
                      ],),
                    SizedBox(height: 4,),


                  ],
                ),
              ),
            ),
          ),
        );
      })
    );
  }

  getMyBooks()async
  {
    setState(() {
      isLoading=true;
    });

    ApiClient api=getItInstance();
    Map<String,String>params=Map();

    params['uid']=ApiConstants.USER_ID;


    var response= await api.post(ApiConstants.my_bookings,body: params,fakeData: false );
    ApiResponse apiResposne=ApiResponse.fromMap(response);
    if(apiResposne==null)
    {
      setState(() {
        isLoading=false;
      });
      Fluttertoast.showToast(msg: "Please try again", toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: AppColor.pink,
          textColor: Colors.white,
          fontSize: 16.0);
      return;
    }
    //Fluttertoast.showToast(msg: apiResposne.msg);

    if(apiResposne.code=='5')
    {


      List<Booking>listdata=List.empty(growable: true);
      apiResposne.data.forEach((a) {
        listdata.add(Booking.fromJson(a));
      });

      setState(() {
        isLoading=false;
        myBookingsList.clear();
        myBookingsList.addAll(listdata);
      });


      return;
    }
    setState(() {
      isLoading=false;
    });
   /* Fluttertoast.showToast(msg: apiResposne.msg, toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: AppColor.pink,
        textColor: Colors.white,
        fontSize: 16.0);*/
  }
  getStatusWidget(Booking myBooking) {
    if(myBooking.status==0) return TextButton(

      style: ButtonStyle(
        minimumSize: MaterialStateProperty.all(Size(80,10)),
        elevation: MaterialStateProperty.all(0),
        backgroundColor: MaterialStateProperty.all(
            AppColor.orange

        ),

      ), onPressed: () {

    }, child:Text("Pending",style: TextStyle(color: Colors.white,fontSize: 10),),
    ); else  if(myBooking.status==1) return TextButton(

      style: ButtonStyle(
        minimumSize: MaterialStateProperty.all(Size(80,10)),
        elevation: MaterialStateProperty.all(0),
        backgroundColor: MaterialStateProperty.all(
            AppColor.orange

        ),

      ), onPressed: () {

    }, child:Text("Confirm",style: TextStyle(color: Colors.white,fontSize: 10),),
    );


    else if(myBooking.status==2) return TextButton(

      style: ButtonStyle(
        minimumSize: MaterialStateProperty.all(Size(80,10)),
        elevation: MaterialStateProperty.all(0),
        backgroundColor: MaterialStateProperty.all(
            AppColor.green

        ),

      ), onPressed: () {

    }, child:Text("Completed",style: TextStyle(color: Colors.white,fontSize: 10),),
    );
    else if(myBooking.status==3) return TextButton(

      style: ButtonStyle(
        minimumSize: MaterialStateProperty.all(Size(80,10)),
        elevation: MaterialStateProperty.all(0),
        backgroundColor: MaterialStateProperty.all(
            AppColor.errorColor

        ),

      ), onPressed: () {

    }, child:Text("Rejected",style: TextStyle(color: Colors.white,fontSize: 10),),
    ); else if(myBooking.status==4) return TextButton(

      style: ButtonStyle(
        minimumSize: MaterialStateProperty.all(Size(80,10)),
        elevation: MaterialStateProperty.all(0),
        backgroundColor: MaterialStateProperty.all(
            AppColor.errorColor

        ),

      ), onPressed: () {

    }, child:Text("Cancelled",style: TextStyle(color: Colors.white,fontSize: 10),),
    );
  }
}