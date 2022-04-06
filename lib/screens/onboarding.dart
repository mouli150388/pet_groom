import 'package:flutter/material.dart';
import 'package:pet_groom/shared/app_colors.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'loginscreen.dart';

class OnBoardingScreen extends StatefulWidget{
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  PageController controler=PageController();
  int total_pages=3;
  int current_page=0;

  List<Widget>buildIndicator()
  {
    List<Widget>list=[];

    for(var i=0;i<total_pages;i++)
      {
        list.add(indicator(current_page==i));
      }
    return list;
  }
  Widget indicator(bool isActive)
  {
    return AnimatedContainer(
      margin: EdgeInsets.all(5),
      duration: Duration(milliseconds: 200),
    height: 15,
      width: isActive?30:15,
        decoration: BoxDecoration(
          color: isActive?AppColor.btn_color:AppColor.grey,
          borderRadius: BorderRadius.circular(20)
        ),

    );
  }
  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Column(
            children: [
              Expanded(
                flex: 9,
                  child: PageView(

                    onPageChanged: (val){
                      setState(() {
                        current_page=val;
                      });
                    },
                    controller: controler,
                    children: [
                      Container(

                          child: loadIntro("assets/images/two.jpeg", "${AppLocalizations.of(context)?.choose_service}", "${AppLocalizations.of(context)?.intro_1}")),
                      Container(
                          child: loadIntro("assets/images/one.jpeg", "${AppLocalizations.of(context)?.choose_date_time}", "${AppLocalizations.of(context)?.intro_2}")),
                      Container(
                        child: Stack(
                          children: [
                            loadIntro("assets/images/intro-three.png", "${AppLocalizations.of(context)?.confirm_appointment}", "${AppLocalizations.of(context)?.intro_3}"),
                            Positioned(
                              bottom: 10,right: 10,
                                child: TextButton(child: Text("Continue"),onPressed: (){
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                                return LoginScreen();}));
                            },))
                          ],
                        ),
                      ),
                    ],

              )),
              Expanded(
                  flex: 1,
                  child: Container(
                    child: Column(
                      children: [
                        SizedBox(height: 5,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: buildIndicator(),
                        ),
                        SizedBox(height: 10,),
                      /*  Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            if(current_page>0)MaterialButton(
                              elevation: 10,
                              colorBrightness: Brightness.dark,
                              visualDensity: VisualDensity.adaptivePlatformDensity,
                              height: 45,
                              minWidth: 150,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)
                              ),
                              color: Colors.blueAccent,
                                onPressed: (){
                                  if(current_page==0)
                                  {
                                    return;
                                  }
                                  setState(() {
                                    current_page=current_page-1;
                                  });
                                }, child: Text("Prev")),

                            MaterialButton(
                                elevation: 10,
                                colorBrightness: Brightness.dark,
                                visualDensity: VisualDensity.adaptivePlatformDensity,
                              height: 45,
                              minWidth: 150,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)
                              ),
                              color: Colors.blueAccent,
                                onPressed: (){
                                  if(current_page==2)
                                    {
                                      return;
                                    }
                                  setState(() {
                                    current_page=current_page+1;
                                  });
                                }, child: Text((current_page==2)?"Submit":"Next")),
                          ],
                        ),*/
                      ],

                    ),

              ))
            ],
          ),
        ),
      ),
    );
  }
}

loadIntro(String image,String title,String description)
{
  return Center(
    child: Column(

      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [

        Spacer(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Image.asset(image,fit: BoxFit.cover, height:280),
        ),
        SizedBox(height: 35,),

        Text(title,style: TextStyle(color: AppColor.pink,fontSize: 22,fontWeight: FontWeight.bold,letterSpacing: 1.2),textAlign: TextAlign.center,),
        SizedBox(height: 35,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Text(description,style: TextStyle(color: Colors.black45,fontSize: 16,letterSpacing: 1.2),textAlign: TextAlign.center,),
        ),
        Spacer(),
      ],
    ),
  );
}