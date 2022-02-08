import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pet_groom/core/api/api_constants.dart';
import 'package:pet_groom/core/screen_utils.dart';
import 'package:pet_groom/data/service_model.dart';
import 'package:pet_groom/providers/book_service_provider.dart';
import 'package:pet_groom/shared/app_colors.dart';

import 'package:provider/provider.dart';
class DetailsPage extends StatelessWidget{
  ServiceModel serviceModel;
  DetailsPage(this.serviceModel);
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(backgroundColor: AppColor.grey,),
      body: Column(
      mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: double.infinity,
            height: 220,
            decoration: BoxDecoration(
                gradient:  RadialGradient(
                    colors: [AppColor.scaffoldColor,AppColor.grey/* const Color(0xFF02BB9F)*/]
                ),
                borderRadius: BorderRadiusDirectional.only(bottomStart: Radius.circular(10),bottomEnd: Radius.circular(10))),
            child: Padding(padding: EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 12,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(serviceModel.name,maxLines:3,overflow:TextOverflow.ellipsis,style: TextStyle(color: Colors.white,fontSize: 22,fontWeight: FontWeight.bold),),

                              SizedBox(height: 10,),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.access_time,size: 22,),SizedBox(width: 10,),
                                  Text("${serviceModel.duration}",style: TextStyle(color:AppColor.black,fontSize: 22.sp),),
                                ],
                              ),

                              SizedBox(height: 8),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 24.w,
                                  vertical: 1.h,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.redAccent,
                                  borderRadius: BorderRadius.circular(5.sp),
                                ),
                                child: Text(
                                  '\$${serviceModel.cost}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                ),
                              ),

                            ],
                          )),
                      Image.network("${ApiConstants.baseImageUrl}${serviceModel.image}", height: 150, width:200),


                    ],

                  ),
                  SizedBox(height: 10,),

                  /* if(!from_primepack)Expanded(child: Text((ebook!.data!.freeCourse==0)?"${ebook!.data!.sellingPrice}":"Free")),*/
                ],
              ),),
          ),
          Consumer<BookserviceProvider>(builder: (context,service,child)=>
              MaterialButton(
                minWidth: 200,
                elevation: 5,
                color: (service.checkServiceId(serviceModel.id))?AppColor.errorColor:AppColor.btn_color,


                onPressed: () {
                  service.addService(serviceModel);
                  /* Navigator.push(context, MaterialPageRoute(builder: (context){
                        return BookingScreen();}));*/
                }, child: Text((service.checkServiceId(serviceModel.id))?"Remove":"Book",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
              ),),
          SizedBox(height: 20,),
          Text("Description ",textAlign:TextAlign.start,
            style: TextStyle(fontSize: 22,color: AppColor.font_header,fontWeight: FontWeight.bold),),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(serviceModel.description,style: TextStyle(fontSize: 20),),
            ),
          ),


        ],
      ),
    );
  }

}