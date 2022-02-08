import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pet_groom/core/api/api_client.dart';
import 'package:pet_groom/core/api/api_constants.dart';
import 'package:pet_groom/core/screen_utils.dart';
import 'package:pet_groom/data/repositories/user_local_data_source.dart';
import 'package:pet_groom/data/service_model.dart';
import 'package:pet_groom/di/dependency_injection.dart';
import 'package:pet_groom/domain/entities/response_entity.dart';
import 'package:pet_groom/domain/entities/user_entity.dart';
import 'package:pet_groom/providers/book_service_provider.dart';
import 'package:pet_groom/screens/dashboard/widgets/home_list.dart';
import 'package:pet_groom/screens/widgets/loading_circle.dart';
import 'package:pet_groom/search/search_delegate.dart';
import 'package:pet_groom/shared/app_bar.dart';
import 'package:pet_groom/shared/app_colors.dart';
import 'package:pet_groom/shared/header_text.dart';
import 'package:provider/provider.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class HomeScreen extends StatefulWidget{
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading=false;
  List<ServiceModel>serviceList=List.empty(growable: true);
  List<ServiceModel>adonserviceList=List.empty(growable: true);
  List<ServiceModel>searchServices=List.empty(growable: true);
  UserEntity? user;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   UserLocalDataSourceImpl().getUser().then((value)  {
     user=value;
     ApiConstants.USER_ID=user!.id;
     ApiConstants.USER_Name=user!.name;
     ApiConstants.IMAGE=user!.profile_picture;
   });
    getServiceS();

  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColor.scaffoldColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView(

            children: [
              SizedBox(height: 12.h,),
              if(isLoading) LoadingCircle(size: 75,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                if(user!=null)  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("Hello!",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 24.sp),),
                      Text("${ApiConstants.USER_Name}",style: TextStyle(color:AppColor.lightPrimary,fontWeight: FontWeight.bold,fontSize: 22.sp),),
                    ],
                  ),
                 if(user!=null) CachedNetworkImage(
                    imageBuilder: (context, imageProvider) => Container(
                      height: 54,
                      width: 54,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(22)),
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    progressIndicatorBuilder: (context, url, progress) => Center(
                      child: CircularProgressIndicator(
                        value: progress.progress,
                      ),
                    ),
                    imageUrl:

                    (ApiConstants.IMAGE==null||ApiConstants.IMAGE.isEmpty)?"https://cdn-icons-png.flaticon.com/512/3135/3135715.png":"${ApiConstants.baseUserProfile}${ApiConstants.IMAGE}",
                  ) else CircleAvatar(
                   child: Container(
                     height: 60,
                     width: 60,
                     decoration: BoxDecoration(
                         image: DecorationImage(
                             image: AssetImage(
                               "assets/images/user.png",
                             ))),
                   ),
                   radius: 48.0,
                 ),
                  /*CircleAvatar(
                      radius: 24, backgroundImage: NetworkImage("https://cdn3.vectorstock.com/i/1000x1000/53/42/user-member-avatar-face-profile-icon-vector-22965342.jpg")),*/
                ],
              ),
              SizedBox(height: 12.h,),
              TextField(
                readOnly: true,
                onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (ctx){
                  return SearchData(searchServices: searchServices);
                })),
                decoration: InputDecoration(
                    fillColor: Colors.white,
                    focusedBorder:  OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 2.0),
                    ),
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 2.0),
                    ),
                    hintText: '${AppLocalizations.of(context)?.search_by_address}',
                    prefixIcon: IconButton(

                      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (ctx){
                        return SearchData(searchServices: searchServices);
                      })),
                      icon: const Icon(Icons.search,color: Colors.grey,),
                    )
                ),
              ),
              SizedBox(height: 12.h,),
              Container(width:double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("${AppLocalizations.of(context)?.available} ",textAlign:TextAlign.start,
                style: TextStyle(fontSize: 22,color: AppColor.font_header,fontWeight: FontWeight.bold),),
          Consumer<BookserviceProvider>(builder: (context,service,child)=> Visibility(
            visible: service.serviceIds.length>0,
              child: FloatingActionButton(
                mini: true,
                backgroundColor: AppColor.pink,
                child: Icon(Icons.arrow_forward),
                onPressed: (){
                  Navigator.pushNamed(
                      context, "/bookingScreen");
                 /* showDialog(
                    barrierDismissible: false,
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(

                          title: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Align(
                                alignment: Alignment.topRight,
                                child: IconButton(

                                  onPressed: (){
                                    Navigator.pop(context);
                                  },icon: Icon(Icons.close),
                                 ),
                              ),
                              Container(child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Addon Services',style: TextStyle(color: Colors.white),),
                              ),color: AppColor.pink,),
                            ],
                          ),
                          content: setupAlertDialoadContainer(context),
                        );
                      }
                  );*/
          },)) )
                    ],
                  )),
              (serviceList.length<=0)?Center(
                child: Text("No data available",style: TextStyle(fontSize: 20,color: Colors.black),),
              ): Container(
                height: 250,
                child: ListView.builder(

                  scrollDirection: Axis.horizontal,
                    physics: const ClampingScrollPhysics(),

                    itemCount: serviceList.length,
                    itemBuilder: (context,index){
                      return HomeListWidget(serviceList[index]);
                    }),
              ),
              SizedBox(height: 10,)
              ,
              Text("Addon Services ",textAlign:TextAlign.start,
                style: TextStyle(fontSize: 22,color: AppColor.font_header,fontWeight: FontWeight.bold),),
              (adonserviceList.length<=0)?Center(
                child: Text("No data available",style: TextStyle(fontSize: 20,color: Colors.black),),
              ): Container(
                height: 250,
                child: ListView.builder(

                    scrollDirection: Axis.horizontal,
                    physics: const ClampingScrollPhysics(),
                    itemCount: adonserviceList.length,
                    itemBuilder: (context,index){
                      return HomeListWidget(adonserviceList[index]);
                    }),
              )
            ],
        ),
      ),
    );
  }
 /* Widget setupAlertDialoadContainer(context) {
    //adonserviceList.fold(initialValue, (previousValue, element) => element.)
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          color: Colors.grey,
          height: 300.0, // Change as per your requirement
          width:500, // Change as per your requirement
          child: ListView.builder(
              physics: const ClampingScrollPhysics(),
              shrinkWrap: true,
              itemCount: adonserviceList.length,
              itemBuilder: (context,index){
                return HomeListWidget(adonserviceList[index]);
              }),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Consumer<BookserviceProvider>(builder: (context,service,child)=>TextButton(

              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(Size(100.w, 10.h)),
                elevation: MaterialStateProperty.all(5),
                backgroundColor: MaterialStateProperty.all(
                   AppColor.pink

                ),

              ), onPressed: () {
                Navigator.pop(context);
                if(service.getCount()<=0)
                  {
                    Fluttertoast.showToast(msg: "Please Select Service");
                    return;
                  }
              Navigator.pushNamed(
                  context, "/bookingScreen");

            }, child: Text("Continue",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
            ),
          ),
        )
      ],
    );
  }*/

  getServiceS()async
  {
    setState(() {
      isLoading=true;
    });

    ApiClient api=getItInstance();
    var response= await api.post(ApiConstants.service,body: {},fakeData: false );
    ApiResponse apiResposne=ApiResponse.fromMap(response);

    //Fluttertoast.showToast(msg: apiResposne.msg);

    if(apiResposne.code=='5')
    {
      var list=ServiceModel.parseList(apiResposne.data) as List<ServiceModel>;
      searchServices.clear();
      searchServices.addAll(list);
      list.forEach((element) {
        if(element.service_type=="main")
          serviceList.add(element);
        else if(element.service_type=="ad_on")
          adonserviceList.add(element);
      });
     /* adonserviceList
      serviceList.addAll(ServiceModel.parseList(apiResposne.data));*/
      setState(() {
        isLoading=false;
      });


    }
  }
}