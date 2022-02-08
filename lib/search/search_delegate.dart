import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pet_groom/core/api/api_constants.dart';
import 'package:pet_groom/core/screen_utils.dart';
import 'package:pet_groom/data/service_model.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pet_groom/providers/book_service_provider.dart';
import 'package:pet_groom/screens/dashboard/details_page.dart';
import 'package:pet_groom/shared/app_colors.dart';

import 'package:provider/provider.dart';
class SearchData extends StatefulWidget{
  List<ServiceModel>searchServices;
  SearchData({required this.searchServices});
  @override
  State<SearchData> createState() => _SearchDataState();
}

class _SearchDataState extends State<SearchData> {

  List<ServiceModel>searchServicesData=List.empty(growable: true);
  TextEditingController _search=TextEditingController();
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: InkWell(
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        title:  Container(
          height: 48,
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          child: TextField(
            onChanged: (text)
            {
              searchData();
            },
      controller: _search,

            decoration: InputDecoration(

                fillColor: Colors.white,
                hintStyle: TextStyle(color: Colors.black),
                focusedBorder:  OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 2.0),
                ),
                filled: true,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 2.0),
                ),
                hintText: '${AppLocalizations.of(context)?.search_by_address}',
                suffixIcon: IconButton(

                  onPressed: () {
                    searchData();
                  },
                  icon: const Icon(Icons.search,color: Colors.grey,),
                ),

            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 16),
        child: InkWell(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          child: (searchServicesData.length<=0)?Center(
            child: Text("No search data available",style: TextStyle(fontSize: 20,color: Colors.black),),
          ):ListView.builder(itemBuilder: (ctx,index){
            var serviceModel=searchServicesData[index];
            return Consumer<BookserviceProvider>(builder: (context,service,child)=>Card(
              color: Colors.white,
              child: InkWell(
                onTap: (){
                  Navigator.push(
                      context,  MaterialPageRoute(builder: (context){
                    return DetailsPage(serviceModel);
                  }));

                },
                child: Container(

                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(width: double.infinity,child: Image.network("${ApiConstants.baseImageUrl}${serviceModel.image}",height: 100, fit: BoxFit.fitWidth,)),
                         Padding(
                           padding: const EdgeInsets.all(8.0),
                           child: Column(

                             mainAxisSize: MainAxisSize.min,
                             crossAxisAlignment: CrossAxisAlignment.start,

                             children: [
                               Text("${serviceModel.name} ",maxLines:2,overflow:TextOverflow.ellipsis,style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 18.sp),),
                               SizedBox(height: 2.h,),

                               Row(
                                 mainAxisSize: MainAxisSize.min,
                                 children: [
                                   Icon(Icons.access_time,size: 16,),SizedBox(width: 10,),
                                   Text("${serviceModel.duration}",style: TextStyle(color:AppColor.black,fontSize: 14.sp),),
                                 ],
                               ),
                               SizedBox(height: 2.h,),


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
            ) );
          },itemCount: searchServicesData.length,),
        ),
      )
    );
  }

  void searchData() {
    if(_search.text.isEmpty)
      {
        setState(() {
          searchServicesData.clear();
        });
        return;
      }
    setState(() {
      searchServicesData.clear();
    });

    print("OnSearch data ${_search.text}");
    widget.searchServices.forEach((element) {
      if(element.name.toLowerCase().contains(_search.text.toLowerCase()))
        {
          print("OnSearch data contains ${_search.text}");
          setState(() {
            searchServicesData.add(element);
          });
        }


    });
  }
}
/*
class AppSearchDelegate extends SearchDelegate {

  List<ServiceModel>searchServices;
  List<ServiceModel>searchServicesData=List.empty(growable: true);

  AppSearchDelegate({required this.searchServices})
      : super(searchFieldLabel:"");

  @override
  ThemeData appBarTheme(BuildContext context) {
    final Map<int, Color> _yellow700Map = {
      50: Color(0xFFFFFFFF),
      100: Colors.white,

    };
    return ThemeData(
      primarySwatch: Colors.grey,
        appBarTheme:  AppBarTheme(
      elevation: 0,


      backgroundColor: Colors.white,
    ));
  }

  @override
  Widget buildLeading(BuildContext context) {
    return GestureDetector(
      onTap: () {

        close(context, null);
      },
      child: Icon(
        Icons.arrow_back_ios,
        color: Theme.of(context).unselectedWidgetColor,
      ),
    );
  }

  @override
  String get query {
    if (super.query.length > 2) {
      searchServicesData.clear();
      searchServices.forEach((element) {
        if(element.name.contains(super.query))
          searchServicesData.add(element);
      });
    } else {

    }
    return super.query;
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      if (query.isNotEmpty)
        IconButton(
          icon: Icon(
            Icons.clear,
            color: Theme.of(context).unselectedWidgetColor,
          ),
          onPressed: () => query = '',
        ),
    ];
  }

  Widget widgetTobeRendered = const SizedBox.shrink();

  @override
  Widget buildResults(BuildContext context) => widgetTobeRendered;

  @override
  Widget buildSuggestions(BuildContext context) {
    return InkWell(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: ListView.builder(itemBuilder: (ctx,index){
        return Text("sd");
      },itemCount: searchServicesData.length,),
    );
  }
}*/
