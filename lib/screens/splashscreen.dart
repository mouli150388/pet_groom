import 'package:flutter/material.dart';
import 'package:pet_groom/data/repositories/user_local_data_source.dart';
import 'package:pet_groom/shared/app_colors.dart';

class SplashScreen extends StatefulWidget{
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 8),() async{
      UserLocalDataSource _userLocalDataSource=UserLocalDataSourceImpl();
      var user=await _userLocalDataSource.getUser();
      if(user==null)
      Navigator.pushReplacementNamed(context, '/onboarding');
      else
      Navigator.pushReplacementNamed(context, '/dashboard');
    });
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColor.black,
      body: Container(

        child: Center(child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(child: Image.asset("assets/images/splash.gif",)),
            /*SizedBox(height: 20,),
            Text("PET GROOM",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color: AppColor.pink),)*/
          ],
        ),),
      ),
    );
  }
}