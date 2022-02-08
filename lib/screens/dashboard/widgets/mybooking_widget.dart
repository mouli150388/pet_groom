import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pet_groom/core/screen_utils.dart';
import 'package:pet_groom/data/booking.dart';
import 'package:pet_groom/shared/app_colors.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../booking_details.dart';
class MyBookingWidget extends StatelessWidget{
  Booking myBooking;
  MyBookingWidget(this. myBooking);

  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: ()async {
       var response=await Navigator.push(
            context, MaterialPageRoute(builder: (ctx){
              return MyBookingDetails(myBooking);
        }));
       if(response!=null&&response==1)
         myBooking.status==3;
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
                    getStatusWidget()

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
  }

  getStatusWidget() {
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