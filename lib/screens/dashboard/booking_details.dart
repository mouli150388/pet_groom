
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pet_groom/core/api/api_client.dart';
import 'package:pet_groom/core/api/api_constants.dart';
import 'package:pet_groom/core/screen_utils.dart';
import 'package:pet_groom/data/booking.dart';
import 'package:pet_groom/di/dependency_injection.dart';
import 'package:pet_groom/domain/entities/response_entity.dart';
import 'package:pet_groom/shared/app_colors.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pet_groom/shared/button_widget.dart';
class MyBookingDetails extends StatefulWidget{
  Booking myBooking;
  MyBookingDetails(this. myBooking);

  @override
  State<MyBookingDetails> createState() => _MyBookingDetailsState();
}

class _MyBookingDetailsState extends State<MyBookingDetails> {
 late List<String> names;
 bool isLoading=false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  names=  widget.myBooking.services_name.split(",").toList();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColor.scaffoldColor,
      appBar: AppBar(
        leading: InkWell(
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Booking Details",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 16),
        child: ListView(
          shrinkWrap: true,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              getStatusWidget(),
              SizedBox(
                  child:
                  createText('${widget.myBooking.booking_date} - ${widget.myBooking.booking_time}:00'),
                  ),

            ]),
            SizedBox(
              height: 4.h,
            ),
            Divider(
              thickness: 1,
              color: AppColor.grey,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              Expanded(
                child: createHeaderText(
                    '${AppLocalizations.of(context)?.service_name}'),
              ),
              SizedBox(
                  child:
                  createHeaderText('${AppLocalizations.of(context)?.cost}'),
                  width: 80.w),

            ]),
            SizedBox(
              height: 4.h,
            ),
            Divider(
              thickness: 1,
              color: AppColor.grey,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for(int k=0;k<names.length;k++)
                    Padding(
                      padding: const EdgeInsets.only(top:4.0),
                      child: FittedBox(
                        child: createText(
                            '${names[k]}'),
                      ),
                    ),
                ],
              ),



              SizedBox(
                  child:
                  createText('\$${widget.myBooking.total_cost}'),
                  width: 80.w),

            ]),
            SizedBox(
              height: 4.h,
            ),

            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(
                    child: createText(
                        "${AppLocalizations.of(context)?.total_fee}:\n \$${widget.myBooking.total_cost}"),
                    width: 80.w),
                Divider(
                  thickness: 1,
                  color: AppColor.grey,
                  height: 8.h,
                ),
                SizedBox(
                  height: 4.h,
                ),

                if(widget.myBooking.status==0||widget.myBooking.status==1)(isLoading)? Center(child:CircularProgressIndicator()):AppPrimaryButton(
                  onPress: () {

                    cancelBooking();

                  },
                  text: '${AppLocalizations.of(context)?.cancel_booking}',
                  width: 150.w,
                  fontsize: 14,
                  color: Colors.red,
                )
              ],
            ),
            SizedBox(
              height: 4.h,
            ),
            Divider(
              thickness: 1,
              color: AppColor.grey,
              height: 8.h,
            ),
            SizedBox(
              height: 8.h,
            ),
          ],
        ),
      ),
    );
  }

  createHeaderText(String text) {
    return Text(
      text,
      style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
    );
  }

  createText(String text) {
    return Text(
      text,
      style: TextStyle(fontSize: 16.sp),
    );
  }
 getStatusWidget() {
   if(widget.myBooking.status==0) return TextButton(

     style: ButtonStyle(
       minimumSize: MaterialStateProperty.all(Size(80,10)),
       elevation: MaterialStateProperty.all(0),
       backgroundColor: MaterialStateProperty.all(
           AppColor.orange

       ),

     ), onPressed: () {

   }, child:Text("Pending",style: TextStyle(color: Colors.white,fontSize: 10),),
   ); else  if(widget.myBooking.status==1) return TextButton(

     style: ButtonStyle(
       minimumSize: MaterialStateProperty.all(Size(80,10)),
       elevation: MaterialStateProperty.all(0),
       backgroundColor: MaterialStateProperty.all(
           AppColor.orange

       ),

     ), onPressed: () {

   }, child:Text("Confirm",style: TextStyle(color: Colors.white,fontSize: 10),),
   );


   else if(widget.myBooking.status==2) return TextButton(

     style: ButtonStyle(
       minimumSize: MaterialStateProperty.all(Size(80,10)),
       elevation: MaterialStateProperty.all(0),
       backgroundColor: MaterialStateProperty.all(
           AppColor.green

       ),

     ), onPressed: () {

   }, child:Text("Completed",style: TextStyle(color: Colors.white,fontSize: 10),),
   );
   else if(widget.myBooking.status==3) return TextButton(

     style: ButtonStyle(
       minimumSize: MaterialStateProperty.all(Size(80,10)),
       elevation: MaterialStateProperty.all(0),
       backgroundColor: MaterialStateProperty.all(
           AppColor.errorColor

       ),

     ), onPressed: () {

   }, child:Text("Rejected",style: TextStyle(color: Colors.white,fontSize: 10),),
   ); else if(widget.myBooking.status==4) return TextButton(

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
 cancelBooking()async
 {
   setState(() {
     isLoading=true;
   });

   ApiClient api=getItInstance();
   Map<String,String>params=Map();

   params['uid']=ApiConstants.USER_ID;
   params['bid']=widget.myBooking.id;


   var response= await api.post(ApiConstants.booking_cancel,body: params,fakeData: false );
   ApiResponse apiResposne=ApiResponse.fromMap(response);

   //Fluttertoast.showToast(msg: apiResposne.msg);
   Fluttertoast.showToast(msg: apiResposne.msg, toastLength: Toast.LENGTH_SHORT,
       gravity: ToastGravity.BOTTOM,
       timeInSecForIosWeb: 1,
       backgroundColor: AppColor.pink,
       textColor: Colors.white,
       fontSize: 16.0);
   if(apiResposne.code=='27')
   {
     Navigator.pop(context,1);


     return;
   }
   setState(() {
     isLoading=false;
   });

 }
}