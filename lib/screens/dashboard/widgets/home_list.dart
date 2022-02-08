import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:pet_groom/core/api/api_constants.dart';
import 'package:pet_groom/core/screen_utils.dart';
import 'package:pet_groom/data/service_model.dart';
import 'package:pet_groom/providers/book_service_provider.dart';
import 'package:pet_groom/screens/booking/bookings.dart';
import 'package:pet_groom/screens/widgets/readmore.dart';
import 'package:pet_groom/shared/app_colors.dart';
import 'package:provider/provider.dart';

import '../details_page.dart';

class HomeListWidget extends StatelessWidget{
  ServiceModel serviceModel;
  HomeListWidget(this. serviceModel);

  @override
  Widget build(BuildContext context) {


    return  Consumer<BookserviceProvider>(builder: (context,service,child)=>Card(
      color: Colors.white,
      child: InkWell(
        onTap: (){
          Navigator.push(
              context,  MaterialPageRoute(builder: (context){
                return DetailsPage(serviceModel);
          }));

        },
        child: Container(
          width: 200,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
               /* CircleAvatar(
                    radius: 32, backgroundImage: NetworkImage("${ApiConstants.baseImageUrl}${serviceModel.image}")),*/
            Container(width: double.infinity,child: Image.network("${ApiConstants.baseImageUrl}${serviceModel.image}",height: 100, width:180,fit: BoxFit.scaleDown,)),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${serviceModel.name}",maxLines:2,style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 18.sp),),
                      SizedBox(height: 2.h,),

                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.access_time,size: 16,),SizedBox(width: 10,),
                          Text("${serviceModel.duration}",style: TextStyle(color:AppColor.black,fontSize: 14.sp),),
                        ],
                      ),
                      SizedBox(height: 2.h,),
                      /*ReadMoreText("${serviceModel.description}", colorClickableText: Colors.red,  trimLines: 2,  trimMode: TrimMode.Line,
                        trimCollapsedText: '...Read more',
                        trimExpandedText: ' Hide',),*/

                    ],
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("${serviceModel.cost}\$",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w100,fontSize: 18.sp),),

                    TextButton(

                      style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all(Size(100.w, 10.h)),
                        elevation: MaterialStateProperty.all(5),
                        backgroundColor: MaterialStateProperty.all(
                            (service.checkServiceId(serviceModel.id))?AppColor.errorColor:AppColor.btn_color

                        ),

                      ), onPressed: () {
                      service.addService(serviceModel);
                     /* Navigator.push(context, MaterialPageRoute(builder: (context){
                        return BookingScreen();}));*/
                    }, child: Text((service.checkServiceId(serviceModel.id))?"Remove":"Book",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    )

    );
  }

}