
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pet_groom/core/api/api_client.dart';
import 'package:pet_groom/core/api/api_constants.dart';
import 'package:pet_groom/data/auth_datasource.dart';
import 'package:pet_groom/di/dependency_injection.dart';
import 'package:pet_groom/domain/entities/response_entity.dart';
import 'package:pet_groom/screens/onboarding.dart';
import 'package:pet_groom/screens/signupscreen.dart';
import 'package:pet_groom/screens/widgets/loading_circle.dart';
import 'package:pet_groom/shared/app_colors.dart';
import 'package:pet_groom/shared/button_widget.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class OTPScreen extends StatefulWidget {
  final String phone;
  final String otp;
  OTPScreen(this.phone, this.otp);
  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  bool isLoading=false;
  AuthDataSource authDataSource=getItInstance();
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  late String _verificationCode;
  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();
  final BoxDecoration pinPutDecoration = BoxDecoration(
    color: const Color.fromRGBO(43, 46, 66, 1),
    borderRadius: BorderRadius.circular(10.0),
    border: Border.all(
      color: const Color.fromRGBO(126, 203, 224, 1),
    ),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffoldColor,
      key: _scaffoldkey,
      appBar: AppBar(
        leading: InkWell(child: Icon(Icons.arrow_back_ios,color: Colors.black,),onTap: (){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
            return SignupScreen();}));
        },),
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Center(child: Text('OTP Verification',style: TextStyle(color: Colors.black),)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20,),
            Image.asset("assets/images/logo-small.png",height: 120,),
            Container(
              margin: EdgeInsets.only(top: 40),
              child: Center(
                child: Text(
                  'Verify +91-${widget.phone}',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left:30.0,right: 30,top: 30),
              child: PinCodeTextField(
                appContext: context,
                    length: 6,
                    obscureText: true,
                    obscuringCharacter: '*',
                    animationType: AnimationType.fade,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(5),
                      fieldHeight: 50,
                      fieldWidth: 40,
                      activeFillColor: Colors.white,
                      ),
                    animationDuration: Duration(milliseconds: 300),

                      onCompleted: (v) async{
                      if(v.length>5&& v==widget.otp )
                        {
                          if(_verificationCode.length>5&& _verificationCode==widget.otp )
                          {
                            //Navigator.pushReplacementNamed(context, "/dashboard");
                            setOTPUpdate();
                          }else
                          {
                            Fluttertoast.showToast(msg: "Please Enter valid OTP", toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: AppColor.pink,
                                textColor: Colors.white,
                                fontSize: 16.0);

                          }
                        }else
                          {
                            Fluttertoast.showToast(msg: "Please Enter valid OTP", toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: AppColor.pink,
                                textColor: Colors.white,
                                fontSize: 16.0);

                          }

                      },
                      onChanged: (value) {
                        _verificationCode=value;


                      },
                    ),


            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(alignment:Alignment.bottomRight,child: TextButton(onPressed: () async{
                Map<String,dynamic>params=Map();
                params['phone']=widget.phone;
                ApiResponse apiResposne=await authDataSource.signupUser(params);
                Fluttertoast.showToast(msg: apiResposne.msg, toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: AppColor.pink,
                    textColor: Colors.white,
                    fontSize: 16.0);

              }, child: Text("Resend OTP",style: TextStyle(color: Colors.black),))),
            ),


            (isLoading)? Center(child: LoadingCircle(size: 75,)):  AppPrimaryButton(onPress: (){
              if(_verificationCode.length>5&& _verificationCode==widget.otp )
              {
                setOTPUpdate();
                //Navigator.pushReplacementNamed(context, "/dashboard");
              }else
              {
                Fluttertoast.showToast(msg: "Please Enter valid OTP", toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: AppColor.pink,
                    textColor: Colors.white,
                    fontSize: 16.0);

              }


            },text: "${AppLocalizations.of(context)?.submit}",),
          ],
        ),
      ),
    );
  }



  setPassword(uid)
  {

    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => OnBoardingScreen()),
            (route) => false);



  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //setOTPUpdate();
  }

  setOTPUpdate()async
  {
    setState(() {
      isLoading=true;
    });

    ApiClient api=getItInstance();
    var response= await api.post(ApiConstants.updateUserstatus,body: {"phone":widget.phone},fakeData: false );
    ApiResponse apiResposne=ApiResponse.fromMap(response);


    if(apiResposne.code=='21')
    {

      Navigator.pushReplacementNamed(context, "/dashboard");

return;
    }
    Fluttertoast.showToast(msg: apiResposne.msg, toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: AppColor.pink,
        textColor: Colors.white,
        fontSize: 16.0);
    setState(() {
      isLoading=false;
    });
  }
}