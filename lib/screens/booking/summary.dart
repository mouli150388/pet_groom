import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pet_groom/core/api/api_client.dart';
import 'package:pet_groom/core/api/api_constants.dart';
import 'package:pet_groom/core/screen_utils.dart';
import 'package:pet_groom/di/dependency_injection.dart';
import 'package:pet_groom/domain/entities/response_entity.dart';
import 'package:pet_groom/providers/book_service_provider.dart';
import 'package:pet_groom/shared/app_colors.dart';
import 'package:pet_groom/shared/button_widget.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:provider/provider.dart';
class BookingSummary extends StatefulWidget {
  @override
  State<BookingSummary> createState() => _BookingSummaryState();
}

class _BookingSummaryState extends State<BookingSummary> {
  bool isLoading=false;
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
          "${AppLocalizations.of(context)?.booking_summary}",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
        child:  Consumer<BookserviceProvider>(builder: (context,service,child)=>ListView(

            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  createHeaderText("Date: ${service.date}"),
                  createHeaderText("Time: ${service.timeslot}:00"),
                ],
              ),
              SizedBox(
                height: 6.h,
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
                SizedBox(
                  child:
                      createHeaderText('${AppLocalizations.of(context)?.time}'),
                  width: 80.w,
                ),
              ]),
              SizedBox(
                height: 4.h,
              ),
              Divider(
                thickness: 1,
                color: AppColor.grey,
              ),
              SizedBox(
                height: 4.h,
              ),

              ListView.builder(
                shrinkWrap: true,
                  itemCount: service.serviceIds.length,
                  itemBuilder: (ctx,index){
                return Column(
                  children: [
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                      Expanded(
                        child: createText('${service.serviceIds[index].name}'),
                      ),
                      SizedBox(child: createText('\$${service.serviceIds[index].cost}'), width: 80.w),
                      SizedBox(
                        child: createText('${service.serviceIds[index].duration}'),
                        width: 80.w,
                      ),
                    ]),
                    Divider(
                      thickness: 1,
                      color: AppColor.grey,
                      height: 5.h,
                    )
                  ],
                );
              })
              ,
             /* SizedBox(
                height: 4.h,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Expanded(
                  child: createText('Name 1'),
                ),
                SizedBox(child: createText('\$150'), width: 80.w),
                SizedBox(
                  child: createText('30 min'),
                  width: 80.w,
                ),
              ]),
              Divider(
                thickness: 1,
                color: AppColor.grey,
                height: 5.h,
              ),
              SizedBox(
                height: 4.h,
              ),*/
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                      child: createText(
                          "${AppLocalizations.of(context)?.total_fee}:\n \$${service.getTotalPrice()}"),
                      width: 80.w),
                  Divider(
                    thickness: 1,
                    color: AppColor.grey,
                    height: 8.h,
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  SizedBox(
                      child: createText(
                          "${AppLocalizations.of(context)?.total_time}: ${service.getTotalTime()} min"),
                      width: 80.w),
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child:   (isLoading)?Center(child: CircularProgressIndicator(),):Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  Expanded(
                      child: AppPrimaryButton(
                        onPress: () {

                          showDialog(
                            context: context,
                            builder: (context) => new AlertDialog(
                              title:  Icon(Icons.info)/*Text("",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.black))*/,
                              content:  Text("Booking Confirmation?",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.black)),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    service.clear();
                                    Navigator.of(context).pop(false);
                                  },
                                  child: new Text('${AppLocalizations.of(context)?.cancel}'),
                                ),
                                TextButton(
                                  onPressed: () {
                          Navigator.of(context).pop(true);
                          var list=service.getIds();
                          bookAppointment(list[0],list[1],service.date,service.timeslot,service.getTotalPrice(),service);
                          } ,
                                  child: new Text('${AppLocalizations.of(context)?.yes}'),
                                ),
                              ],
                            ),
                          );



                        },
                        text: '${AppLocalizations.of(context)?.confirm_booking}',
                        width: 150.w,
                        fontsize: 14,
                      ),
                    ),
                    Expanded(
                      child: AppPrimaryButton(
                        onPress: () {
                          Navigator.pop(context);

                        },
                        text: '${AppLocalizations.of(context)?.cancel_booking}',
                        width: 150.w,
                        fontsize: 14,
                        color: Colors.red,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  createText(String text) {
    return Text(
      text,
      style: TextStyle(fontSize: 16.sp),
    );
  }

  createHeaderText(String text) {
    return Text(
      text,
      style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
    );
  }

  bookAppointment(sid,services_name,booking_date,booking_time,totalCost, BookserviceProvider service)async
  {
    setState(() {
      isLoading=true;
    });

    ApiClient api=getItInstance();
    Map<String,String>params=Map();

    params['uid']=ApiConstants.USER_ID;
    params['booking_date']=booking_date;
    params['booking_time']=booking_time;
    params['totalCost']=totalCost.toString();
    params['sid']=sid;
    params['services_name']=services_name;

    var response= await api.post(ApiConstants.book_appointment,body: params,fakeData: false );
    ApiResponse apiResposne=ApiResponse.fromMap(response);

    //Fluttertoast.showToast(msg: apiResposne.msg);

    if(apiResposne.code=='24')
    {

      service.clear();
      Navigator.pushReplacementNamed(
          context, "/thanksScreen");

      service.clear();

      return;
    }
    Fluttertoast.showToast(msg: apiResposne.msg, toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: AppColor.pink,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
